"""
Shared helpers for the se-workshop-sda check and solve scripts.

Setup copies this file to /opt/harness/sda/. Challenge scripts load it with:

    sys.path.insert(0, "/opt/harness/sda")
    import sda_checks as sda

Checks validate outcomes (a run succeeded, an entity exists, the app answers), never exact
YAML, because the DevOps Agent writes YAML a little differently every time.

For testing outside Instruqt, set SDA_PROJECT and SDA_IMAGE_REPO (and SE_WORKSHOP_* as
usual). SDA_HARNESS_API points the helpers at another cluster, e.g. a vanity domain.
"""

import json
import os
import re
import subprocess
import sys
import time

import requests
import yaml

HARNESS_API = os.getenv("SDA_HARNESS_API", "https://app.harness.io")
ACCOUNT_ID = os.getenv("SE_WORKSHOP_ACCOUNT_ID")
ORG_ID = os.getenv("SE_WORKSHOP_ORG_ID")
PAT = os.getenv("SE_WORKSHOP_PAT")

# Pinned names. The assignments' agent prompts use these, so the checks can find what the
# agent created.
PIPELINE_ID = "showcase"
REPO_ID = "sda-showcase"
IMAGE = "sda-showcase"
SERVICE_ID = "showcase"
ENV_ID = "dev"
INFRA_ID = "k8s_dev"
POLICY_SET_ID = "guardrails"
SDA_DIR = os.getenv("SDA_DIR", "/opt/harness/sda")
YAML_PATH = "se-workshop-sda/assets/yaml_spec"

IN_PROGRESS = {
    "Running", "AsyncWaiting", "TaskWaiting", "TimedWaiting", "Queued", "NotStarted",
    "ResourceWaiting", "InterventionWaiting", "ApprovalWaiting", "WaitStepRunning",
    "Paused", "Pausing", "QueuedLicenseLimitReached", "QueuedExecutionConcurrencyReached",
}
FINISHED_BAD = {"Failed", "Errored", "Aborted", "Expired", "Rejected", "AbortedByFreeze",
                "ApprovalRejected", "Discontinuing"}
# IgnoreFailed: the run passed, but a step whose failure is ignored failed along the way
# (a cold build cache does this on the first run when caching is on)
PASSED = {"Success", "IgnoreFailed"}


# ------------------------------------------------------------------------------------------
# Context and plumbing
# ------------------------------------------------------------------------------------------
def agent_var(name):
    """An Instruqt agent variable, or None outside Instruqt."""
    try:
        out = subprocess.run(["agent", "variable", "get", name], check=True,
                             capture_output=True, text=True)
        return out.stdout.strip() or None
    except (OSError, subprocess.CalledProcessError):
        return None


def project():
    return os.getenv("SDA_PROJECT") or agent_var("HARNESS_PRJ_ID")


def app_url():
    return os.getenv("SDA_APP_URL") or agent_var("APP_URL")


def tf_output(name):
    """A Terraform output that setup saved to tf-outputs.json."""
    try:
        with open(f"{SDA_DIR}/tf-outputs.json") as f:
            return json.load(f)[name]["value"]
    except (OSError, KeyError, ValueError):
        return None


def image_repo():
    """Where CI pushes the image, without a tag: <registry host>/<path>/sda-showcase."""
    return os.getenv("SDA_IMAGE_REPO") or tf_output("image_repo")


def har_host():
    return image_repo().split("/", 1)[0]


def image_path():
    """image_repo() without the host, as a Docker connector's imagePath wants it."""
    return image_repo().split("/", 1)[1]


def fail(message):
    """Show the student why Check failed, then stop the script."""
    try:
        subprocess.run(["fail-message", message], check=False)
    except OSError:
        pass
    print(f"CHECK FAILED: {message}", file=sys.stderr)
    sys.exit(1)


def scope(**extra):
    params = {"accountIdentifier": ACCOUNT_ID, "orgIdentifier": ORG_ID,
              "projectIdentifier": project()}
    params.update(extra)
    return params


def request(method, path, params=None, retries=3, **kwargs):
    """Call the Harness API with the workshop PAT. Retries on 5xx and connection errors."""
    headers = {"x-api-key": PAT, "Load-From-Cache": "false"}
    headers.update(kwargs.pop("headers", {}))
    url = path if path.startswith("http") else f"{HARNESS_API}{path}"
    last = None
    for attempt in range(retries):
        try:
            last = requests.request(method, url, params=params if params is not None else scope(),
                                    headers=headers, timeout=30, **kwargs)
            if last.status_code < 500:
                return last
        except requests.RequestException as e:
            print(f"  {method} {url}: {e}")
        time.sleep(2 * (attempt + 1))
    return last


def must(response, what):
    """Return response JSON, or exit with a readable error (used by solve scripts)."""
    if response is None or not 200 <= response.status_code < 300:
        code = getattr(response, "status_code", "no response")
        body = getattr(response, "text", "")[:500]
        sys.exit(f"{what} failed ({code}): {body}")
    return response.json() if response.content else {}


# ------------------------------------------------------------------------------------------
# Pipelines
# ------------------------------------------------------------------------------------------
def list_pipelines():
    r = request("POST", "/pipeline/api/pipelines/list",
                params=scope(page=0, size=50), json={"filterType": "PipelineSetup"})
    if r is None or r.status_code != 200:
        return []
    return r.json().get("data", {}).get("content", [])


def find_pipeline():
    """The student's pipeline: `showcase` if it exists, else the only pipeline in the project."""
    pipelines = list_pipelines()
    ids = [p.get("identifier") for p in pipelines]
    if PIPELINE_ID in ids:
        return PIPELINE_ID
    if len(ids) == 1:
        return ids[0]
    return None


def pipeline_yaml(pipeline_id):
    r = request("GET", f"/pipeline/api/pipelines/{pipeline_id}")
    if r is None or r.status_code != 200:
        return None
    return r.json().get("data", {}).get("yamlPipeline")


def pipeline_dict(pipeline_id):
    text = pipeline_yaml(pipeline_id)
    return yaml.safe_load(text) if text else None


def stages(pipeline):
    """Every stage dict in pipeline order, with parallel groups flattened."""
    out = []
    for item in (pipeline or {}).get("pipeline", {}).get("stages", []) or []:
        if "stage" in item:
            out.append(item["stage"])
        for p in item.get("parallel", []) or []:
            if "stage" in p:
                out.append(p["stage"])
    return out


def _walk_steps(items):
    for item in items or []:
        if "step" in item:
            yield item["step"]
        if "stepGroup" in item:
            yield from _walk_steps(item["stepGroup"].get("steps"))
        if "parallel" in item:
            yield from _walk_steps(item["parallel"])


def steps(stage, rollback=False):
    """Steps in a stage's execution (or its rollback steps), step groups included."""
    execution = (stage.get("spec") or {}).get("execution") or {}
    return list(_walk_steps(execution.get("rollbackSteps" if rollback else "steps")))


def step_types(pipeline, stage_type=None):
    types = []
    for st in stages(pipeline):
        if stage_type is None or st.get("type") == stage_type:
            types += [s.get("type") for s in steps(st)]
    return types


def has_approval_before_deploy(pipeline):
    """Python twin of the deploy_needs_approval OPA policy."""
    all_stages = stages(pipeline)
    deploys = [s for s in all_stages if s.get("type") == "Deployment"]
    if not deploys:
        return False
    for st in deploys:
        before = all_stages[:all_stages.index(st)]
        if any(s.get("type") == "Approval" for s in before):
            continue
        if "HarnessApproval" in [s.get("type") for s in steps(st)]:
            continue
        return False
    return True


def upsert_pipeline(pipeline_yaml_text, pipeline_id=PIPELINE_ID):
    """Create the pipeline, or replace its YAML if it already exists."""
    exists = request("GET", f"/pipeline/api/pipelines/{pipeline_id}")
    if exists is not None and exists.status_code == 200:
        r = request("PUT", f"/pipeline/api/pipelines/v2/{pipeline_id}", data=pipeline_yaml_text,
                    headers={"Content-Type": "application/yaml"})
    else:
        r = request("POST", "/pipeline/api/pipelines/v2", data=pipeline_yaml_text,
                    headers={"Content-Type": "application/yaml"})
    must(r, f"Saving pipeline {pipeline_id}")


def delegate_selector():
    return f"{project()}-delegate"


def pin_delegate(pipeline_id=None):
    """Make every delegate task in the student's pipeline run on their own delegate.

    Shell Script steps with no selector of their own can land on any delegate the project can
    see, account-level ones included, and those can't resolve this VM's cluster DNS. The agent
    doesn't reliably set step selectors, so this sets one at pipeline level, which every step
    inherits. Harness Cloud CI stages ignore it. The text is edited in place so the agent's YAML
    keeps its formatting. Returns True if the pipeline was changed.
    """
    pipeline_id = pipeline_id or find_pipeline()
    text = pipeline_yaml(pipeline_id) if pipeline_id else None
    if not text:
        print("No pipeline yet; nothing to pin.")
        return False
    wanted = delegate_selector()
    current = (yaml.safe_load(text) or {}).get("pipeline", {}).get("delegateSelectors") or []
    if wanted in current:
        return False
    if current:
        # Unusual: someone set a different pipeline-level selector. Replace it.
        doc = yaml.safe_load(text)
        doc["pipeline"]["delegateSelectors"] = [wanted]
        text = yaml.safe_dump(doc, sort_keys=False, width=1000)
    else:
        m = re.search(r"^pipeline:[ \t]*\n([ \t]+)\S", text, re.M)
        if not m:
            fail(f"Couldn't read the {pipeline_id} pipeline's YAML to pin its delegate.")
        indent = m.group(1)
        insert = f"{indent}delegateSelectors:\n{indent}  - {wanted}\n"
        text = text[:m.end(0) - len(indent) - 1] + insert + text[m.end(0) - len(indent) - 1:]
    upsert_pipeline(text, pipeline_id)
    print(f"Pinned pipeline {pipeline_id} to delegate {wanted}.")
    return True


def render(template_name, **context):
    """Render a yaml_spec template from field-workshops main."""
    base = {"org_id": ORG_ID, "project_id": project(), "account_id": ACCOUNT_ID,
            "image_path": image_path(), "har_host": har_host()}
    base.update(context)
    local = os.path.join(os.getenv("SDA_YAML_DIR", f"{SDA_DIR}/yaml_spec"), template_name)
    if os.path.isfile(local):
        import jinja2
        with open(local) as f:
            return jinja2.Template(f.read()).render(base)
    from pyharnessworkshop import utils
    text = utils.misc.render_template_from_url(base, f"{YAML_PATH}/{template_name}")
    if not text:
        sys.exit(f"Could not render {template_name}")
    return text


# ------------------------------------------------------------------------------------------
# Executions
# ------------------------------------------------------------------------------------------
def executions(pipeline_id, size=20):
    """Newest first."""
    r = request("POST", "/pipeline/api/pipelines/execution/summary",
                params=scope(pipelineIdentifier=pipeline_id, page=0, size=size),
                json={"filterType": "PipelineExecution"})
    if r is None or r.status_code != 200:
        return None
    return r.json().get("data", {}).get("content", [])


def stage_nodes(execution, node_type=None):
    """Stage entries of an execution summary (nodeType is CI, Deployment, Approval, ...)."""
    nodes = (execution.get("layoutNodeMap") or {}).values()
    return [n for n in nodes if node_type is None or n.get("nodeType") == node_type]


def step_nodes(execution, stage_node):
    """Every step node executed in one stage of an execution, rollback steps included.

    Asks for the stage's graph by node execution ID and by node ID and merges the answers,
    because which one returns the full graph has varied between Harness clusters.
    """
    nodes = {}
    for params in ({"stageNodeExecutionId": stage_node.get("nodeExecutionId")},
                   {"stageNodeId": stage_node.get("nodeUuid")}):
        if not list(params.values())[0]:
            continue
        r = request("GET", f"/pipeline/api/pipelines/execution/v2/{execution['planExecutionId']}",
                    params=scope(renderFullBottomGraph="true", **params))
        if r is None or r.status_code != 200:
            print(f"  (step graph by {list(params)[0]}: HTTP {getattr(r, 'status_code', None)})")
            continue
        graph = (r.json().get("data") or {}).get("executionGraph") or {}
        nodes.update(graph.get("nodeMap") or {})
    if not nodes:
        print(f"  (no step graph for stage {stage_node.get('name')})")
    return list(nodes.values())


def rolled_back(execution):
    """True if a Deployment stage in this execution ran any rollback step successfully.

    In a canary that fails its health check, the rolling deploy never ran, so only the
    rollback's canary delete does real work; any successful rollback step counts.
    """
    for node in stage_nodes(execution, "Deployment"):
        for step in step_nodes(execution, node):
            if ".rollbackSteps." in str(step.get("baseFqn", "")) and step.get("status") == "Success" \
                    and str(step.get("stepType", "")).startswith("K8s"):
                return True
    return False


def run_pipeline(pipeline_id, inputs_yaml="", notes="Run by the workshop's Skip button"):
    """Start a run and return its planExecutionId."""
    params = scope(notesForPipelineExecution=notes)
    r = request("POST", f"/pipeline/api/pipeline/execute/{pipeline_id}", params=params,
                data=inputs_yaml, headers={"Content-Type": "application/yaml"})
    data = must(r, f"Running pipeline {pipeline_id}").get("data", {})
    return (data.get("planExecution") or {}).get("uuid")


def execution(plan_execution_id):
    r = request("GET", f"/pipeline/api/pipelines/execution/v2/{plan_execution_id}")
    if r is None or r.status_code != 200:
        return None
    return (r.json().get("data") or {}).get("pipelineExecutionSummary")


def failure_details(summary):
    """Lines naming each failed stage and step, with Harness's error message, for the logs."""
    summary = summary or {}
    lines = []
    run_msg = (summary.get("failureInfo") or {}).get("message", "")
    if run_msg:
        lines.append(f"run failed: {run_msg}")
    for detail in (summary.get("governanceMetadata") or {}).get("details") or []:
        for policy in detail.get("policyMetadata") or []:
            if policy.get("status") == "error":
                lines.append(f"policy {policy.get('identifier')} denied: "
                             f"{'; '.join(policy.get('denyMessages') or [])}")
    for node in stage_nodes(summary):
        if node.get("status") not in FINISHED_BAD:
            continue
        stage_msg = (node.get("failureInfo") or {}).get("message", "")
        lines.append(f"stage {node.get('name')} ({node.get('status')})"
                     + (f": {stage_msg}" if stage_msg != run_msg else ""))
        for step in step_nodes(summary, node):
            step_type = str(step.get("stepType", ""))
            # Skip Harness's wrapper nodes (DEPLOYMENT_STAGE_STEP, NG_SECTION_..., etc.)
            if step.get("status") not in FINISHED_BAD or step_type.isupper():
                continue
            step_msg = (step.get("failureInfo") or {}).get("message", "")
            lines.append(f"  step {step.get('name')} [{step_type}] ({step.get('status')})"
                         + (f": {step_msg}" if step_msg not in (run_msg, stage_msg) else ""))
            if step_type == "ShellScript":
                lines += [f"    | {out}" for out in step_log(step)[-10:]]
    return lines


def step_log(step, command_unit="Execute"):
    """The output lines of one step's command unit, from the log service ([] if unavailable)."""
    key = step.get("logBaseKey")
    if not key:
        return []
    token = request("GET", "/gateway/log-service/token", params={"accountID": ACCOUNT_ID})
    if token is None or token.status_code != 200:
        return []
    r = request("GET", "/gateway/log-service/blob",
                params={"accountID": ACCOUNT_ID, "key": f"{key}-commandUnit:{command_unit}",
                        "X-Harness-Token": token.text.strip()})
    if r is None or r.status_code != 200:
        return []
    out = []
    for raw in r.text.splitlines():
        try:
            out.append(json.loads(raw).get("out", "").rstrip())
        except ValueError:
            continue
    return out


def wait_for(plan_execution_id, timeout=900, until=()):
    """Poll a run until it reaches a status in `until` or finishes. Returns the final status."""
    deadline = time.time() + timeout
    status = None
    while time.time() < deadline:
        summary = execution(plan_execution_id) or {}
        status = summary.get("status")
        print(f"  run {plan_execution_id[:8]}: {status}")
        if status in FINISHED_BAD:
            for line in failure_details(summary):
                print(f"  {line}")
        if status in until or status in FINISHED_BAD or status in PASSED:
            return status
        time.sleep(10)
    return status


def approve_waiting(plan_execution_id, comment="Approved by the workshop's Skip button"):
    """Approve every Harness Approval this run is waiting on. Returns how many it approved."""
    r = request("GET", f"/v1/orgs/{ORG_ID}/projects/{project()}/approvals/execution/{plan_execution_id}",
                params={"approval_status": "WAITING", "approval_type": "HarnessApproval"},
                headers={"Harness-Account": ACCOUNT_ID})
    approvals = r.json() if r is not None and r.status_code == 200 else []
    approved = 0
    for a in approvals or []:
        res = request("POST", f"/pipeline/api/approvals/{a['id']}/harness/activity",
                      params={"accountIdentifier": ACCOUNT_ID},
                      json={"action": "APPROVE", "comments": comment, "approverInputs": []})
        if res is not None and res.status_code == 200:
            approved += 1
        else:
            print(f"  could not approve {a.get('id')}: {getattr(res, 'text', '')[:300]}")
    return approved


# ------------------------------------------------------------------------------------------
# Entities
# ------------------------------------------------------------------------------------------
ENTITY_PATHS = {
    "service": "/ng/api/servicesV2/{id}",
    "environment": "/ng/api/environmentsV2/{id}",
    "infrastructure": "/ng/api/infrastructures/{id}",
}


def entity_exists(kind, identifier, **extra):
    path = ENTITY_PATHS[kind].format(id=identifier)
    params = scope(**extra)
    if kind == "infrastructure":
        params.setdefault("environmentIdentifier", ENV_ID)
    r = request("GET", path, params=params)
    return r is not None and r.status_code == 200 and (r.json().get("data") is not None)


def upsert_entity(kind, identifier, body_yaml):
    """Create or update a Service, Environment or Infrastructure from YAML."""
    collection = {"service": "/ng/api/servicesV2", "environment": "/ng/api/environmentsV2",
                  "infrastructure": "/ng/api/infrastructures"}[kind]
    doc = yaml.safe_load(body_yaml)
    inner = next(iter(doc.values()))
    payload = {"identifier": identifier, "orgIdentifier": ORG_ID, "projectIdentifier": project(),
               "name": inner.get("name", identifier), "yaml": body_yaml}
    if kind == "environment":
        payload["type"] = inner.get("type", "PreProduction")
    if kind == "infrastructure":
        payload["environmentRef"] = inner.get("environmentRef", ENV_ID)
        payload["type"] = inner.get("type", "KubernetesDirect")
    method = "PUT" if entity_exists(kind, identifier) else "POST"
    must(request(method, collection, params={"accountIdentifier": ACCOUNT_ID}, json=payload),
         f"Saving {kind} {identifier}")


# ------------------------------------------------------------------------------------------
# Harness Code
# ------------------------------------------------------------------------------------------
def code(method, path, **kwargs):
    return request(method, f"/code/api/v1/repos/{REPO_ID}{path}", **kwargs)


def code_file(path, ref="main"):
    """A file's text on a branch, or None."""
    r = code("GET", f"/raw/{path}", params=scope(git_ref=f"refs/heads/{ref}"))
    return r.text if r is not None and r.status_code == 200 else None


def code_blob_sha(path, ref="main"):
    r = code("GET", f"/content/{path}", params=scope(git_ref=f"refs/heads/{ref}", include_commit="false"))
    return (r.json() or {}).get("sha") if r is not None and r.status_code == 200 else None


def commit_file(path, text, message, branch="main", new_branch=None):
    """Commit one file. With new_branch, the commit starts that branch from `branch`."""
    body = {
        "title": message,
        "message": "",
        "branch": branch,
        "actions": [{"action": "UPDATE", "path": path, "payload": text,
                     "sha": code_blob_sha(path, branch)}],
    }
    if new_branch:
        body["new_branch"] = new_branch
    return must(code("POST", "/commits", params=scope(), json=body), f"Committing {path}")


def pull_requests(state="merged"):
    r = code("GET", "/pullreq", params=scope(state=state, limit=50))
    return r.json() if r is not None and r.status_code == 200 else []


def open_and_merge_pr(source_branch, title, description=""):
    pr = must(code("POST", "/pullreq", params=scope(),
                   json={"title": title, "description": description,
                         "source_branch": source_branch, "target_branch": "main"}),
              "Opening pull request")
    number = pr.get("number")
    for _ in range(10):  # mergeability is computed asynchronously
        r = code("POST", f"/pullreq/{number}/merge", params=scope(),
                 json={"method": "squash", "source_sha": pr.get("source_sha"),
                       "delete_source_branch": True})
        if r is not None and r.status_code == 200:
            return number
        time.sleep(3)
    must(r, f"Merging pull request #{number}")


# ------------------------------------------------------------------------------------------
# Artifact Registry, policies, the live app
# ------------------------------------------------------------------------------------------
def image_tags():
    """Tags of sda-showcase in the student's HAR registry, via the OCI distribution API."""
    url = f"https://{har_host()}/v2/{image_path()}/tags/list"
    try:
        r = requests.get(url, auth=("harness", PAT), timeout=30)
    except requests.RequestException as e:
        print(f"  {url}: {e}")
        return []
    if r.status_code == 401:
        # Registries answer 401 with a token realm; follow it
        realm = r.headers.get("WWW-Authenticate", "")
        fields = dict(p.split("=", 1) for p in realm.replace("Bearer ", "").split(",") if "=" in p)
        fields = {k: v.strip('"') for k, v in fields.items()}
        if "realm" in fields:
            t = requests.get(fields.pop("realm"), params=fields, auth=("harness", PAT), timeout=30)
            token = (t.json() or {}).get("token") if t.status_code == 200 else None
            if token:
                r = requests.get(url, headers={"Authorization": f"Bearer {token}"}, timeout=30)
    if r.status_code != 200:
        print(f"  tags/list returned {r.status_code}: {r.text[:200]}")
        return []
    return r.json().get("tags") or []


def set_policy_set_enabled(enabled, policy_set_id=POLICY_SET_ID):
    r = request("PATCH", f"/pm/api/v1/policysets/{policy_set_id}", params=scope(),
                json={"enabled": enabled}, headers={"Content-Type": "application/json"})
    must(r, f"{'Enabling' if enabled else 'Disabling'} policy set {policy_set_id}")


def policy_set_enabled(policy_set_id=POLICY_SET_ID):
    r = request("GET", f"/pm/api/v1/policysets/{policy_set_id}", params=scope())
    return r is not None and r.status_code == 200 and bool(r.json().get("enabled"))


def app_get(path, attempts=3):
    """GET a path on the student's live app. Returns the response or None."""
    base = app_url()
    if not base:
        return None
    for i in range(attempts):
        try:
            r = requests.get(f"{base}{path}", timeout=10)
            if r.status_code < 500 or i == attempts - 1:
                return r
        except requests.RequestException as e:
            print(f"  {base}{path}: {e}")
        time.sleep(3)
    return None


FLAVORS = ("ticker", "billboard")


def validate_showcase(text):
    """The app's own validation rules (internal/brand/brand.go), so Check can catch a bad
    showcase.yaml before the build's unit tests do. Returns a problem string or None."""
    import re
    try:
        c = yaml.safe_load(text) or {}
    except yaml.YAMLError as e:
        return f"it isn't valid YAML ({str(e).splitlines()[0]})"
    if not isinstance(c, dict):
        return "it should be a list of settings like `name: ...`"
    flavor = str(c.get("flavor") or "ticker").strip().lower()
    if flavor not in FLAVORS:
        return f"flavor must be ticker or billboard, not {flavor!r}"
    if not re.fullmatch(r"\d+\.\d+\.\d+", str(c.get("version") or "1.0.0")):
        return f"version must look like 1.2.3, not {c.get('version')!r}"
    name = str(c.get("name") or "").strip()
    if not 1 <= len(name) <= 40:
        return "name must be 1 to 40 characters"
    accent = c.get("accent")
    if not re.fullmatch(r"#[0-9A-Fa-f]{6}", str(accent or "")):
        # An unquoted #color is a YAML comment, so accent comes through empty
        return 'accent must be a six-digit hex color in quotes, like "#00ADE4"'
    if len(str(c.get("message") or "")) > 140:
        return "message must be 140 characters or fewer"
    if flavor == "ticker":
        symbols = c.get("symbols") or []
        if not isinstance(symbols, list) or not 1 <= len(symbols) <= 8:
            return "symbols needs 1 to 8 entries, like [USDJPY, EURUSD]"
        for sym in symbols:
            if not re.fullmatch(r"[A-Z0-9.]{1,10}", str(sym).upper()):
                return f"symbol {sym!r} should be letters and digits only, up to 10"
    return None


def showcase(ref="main"):
    """showcase.yaml on a branch, parsed, or {}."""
    try:
        return yaml.safe_load(code_file("showcase.yaml", ref) or "") or {}
    except yaml.YAMLError:
        return {}


def edit_showcase(commit_message, branch="main", new_branch=None, **fields):
    """Change settings in showcase.yaml line by line, so the student's comments and layout
    survive, and commit the result. `healthy` sets release.healthy; any other keyword sets
    the top-level key of that name (pass strings already quoted where YAML needs quotes)."""
    original = text = code_file("showcase.yaml", branch) or seed_text()
    for key, value in fields.items():
        if key == "healthy":
            flag = "true" if value else "false"
            text, n = re.subn(r"(?m)^(\s+healthy:)[^\n]*$", rf"\g<1> {flag}", text)
            if not n:
                text = text.rstrip("\n") + f"\nrelease:\n  healthy: {flag}\n"
        else:
            text, n = re.subn(rf"(?m)^{re.escape(key)}:[^\n]*$", lambda _: f"{key}: {value}", text)
            if not n:
                text = text.rstrip("\n") + f"\n{key}: {value}\n"
    if text != original or new_branch:
        commit_file("showcase.yaml", text, commit_message, branch=branch, new_branch=new_branch)
    return text


def bump_patch(version):
    """1.3.0 -> 1.3.1; anything unparseable becomes 1.0.1."""
    try:
        major, minor, patch = (int(x) for x in str(version).split("."))
    except ValueError:
        return "1.0.1"
    return f"{major}.{minor}.{patch + 1}"


def seed_text(name="showcase.yaml"):
    """The app file as setup seeded it, for 'did the student change it' checks."""
    with open(f"{SDA_DIR}/seed/{name}") as f:
        return f.read()
