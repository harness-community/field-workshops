# Instructor Runbook: Software Delivery Agent Hands-On Workshop

A 2-hour, show-then-do workshop. Students brand a small app, then have the Harness Software
Delivery Agent build its CI pipeline, deploy it to Kubernetes, convert it to a canary with
automatic rollback, and make it pass an OPA policy. Every lab has **Skip** (a solve script that
leaves the student in the correct end state) and **Check** (validates outcomes, not exact YAML,
because the agent is nondeterministic).

- **Track:** `se-workshop-sda` in the `harness-se` Instruqt org
- **Account:** `UL037itkT6SA3IDdIIXWcQ` (Keycloak SSO, a temp user and project per sandbox)
- **Cluster:** each sandbox VM's own k3s. Setup creates the student's namespace and delegate there,
  and the **Your App** tab opens the app's NodePort (30080) on the VM. No shared cluster
- **Assets:** `harness-community/field-workshops` `main`:
  `se-workshop-sda/assets/{app,yaml_spec,lib}` and `assets/terraform/sda-workshop/`

---

## Agenda (120 minutes: 28 show, 92 do)

| Clock | Block | Type | Lab |
|---|---|---|---|
| 0:00 | Kickoff: the SDA story and the autonomous SDLC. **Everyone launches the track at 0:02** (provisioning takes about 5 minutes) | Show 10 | — |
| 0:10 | Log in, brand the app, PR with an AI summary | Do 12 | 0 + 1 |
| 0:22 | How the agent works: prompt → proposal → accept → audit trail | Show 4 | — |
| 0:26 | Agent builds CI; run fails on a seeded bug; Analyze Error; fix; green | Do 25 | 2 |
| 0:51 | Service, Environment, Infrastructure, strategies | Show 4 | — |
| 0:55 | Agent creates Service/Env/Infra and a rolling deploy; app goes live | Do 25 | 3 |
| 1:20 | **The outer loop**: what happens after code leaves a developer's hands. Canary, health gates, automatic rollback | Show 4 | — |
| 1:24 | Agent converts to canary; ship good; ship bad, watch it roll back | Do 20 | 4 |
| 1:44 | Governance: policy as code checks every change, whoever made it | Show 2 | — |
| 1:46 | Policy blocks the run; view the rule; agent adds an approval; approve; ship | Do 10 | 5 |
| 1:56 | Wrap: what you built, the outer loop (safe release, auto rollback, policy on every change), the audit trail, how it maps to your team, next steps | Show 4 | — |
| — | Bonus: explain, audit, extend | Do | Bonus |

**Running behind at 1:20?** In Lab 4, skip the good release and go straight to the bad one.
**Way behind?** Have stragglers click **Skip**; every solve leaves them exactly where the next
lab expects.

---

## Before the workshop

### Day-0 checks (do these in a play session, as the temp user, not as an admin)

These were not verifiable from outside the UI. Fix the assignment wording for any that differ.

- [x] **Where the agent lives.** It's the floating **Ask AI** button at the bottom right, not
      the **AI Agents** item in the left nav. Assignments say "Click **Ask AI**" and "start a **new chat**".
- [ ] **Temp users can use the agent**, and its proposals are accepted with an Accept button.
- [ ] **The agent creates entities from chat**: pipeline, Service, Environment, Infrastructure,
      and it keeps the pinned names and identifiers. Run each lab's prompt **3 times**; rewrite
      any prompt that fails more than once. Fallback if entity creation fails: pre-create
      Service/Env/Infra in track setup (the solve's `upsert_entity` calls already do this) and
      have the agent author only the pipeline.
- [ ] **Analyze Error** appears on a failed CI step (Lab 2) and on a failed Shell Script step
      (Lab 4).
- [ ] **PR AI summary**: the AI button in the pull request description box (Lab 1).
- [ ] **Harness Cloud CI** builds run in this account, without quota or credit errors.
- [ ] **HAR URL on prod-1.** Setup derives the host from the registry's `url` field. Confirm
      the `IMAGE_PATH` shown in Lab 3's service prompt looks right, and that Lab 2's Check finds
      tags.
- [ ] **Instruqt-Var renders inside code blocks** (Lab 3's service prompt).
- [ ] **Backup pipeline YAML** (the "Agent stuck?" block in Labs 2–5): the org and project
      IDs are filled in, the copy button works inside the collapsed block, and pasting it into
      the pipeline's YAML view and saving gives a pipeline that passes the lab's Check. Try it
      in at least one lab. The blocks are generated from `pipeline.yaml.template`: after
      changing the template, re-run `uv run --with jinja2 tools/sda_yaml_backups.py` from the
      repo root.
- [ ] **Policy-blocked run** shows the `deploy_needs_approval` message where Lab 5 says it does.
- [ ] **Policies path**: a temp user finds **Deploys need an approval** under **Project Settings** →
      **Policies** (Lab 5) and can open it read-only.
- [ ] **Audit Trail path**: a temp user (project admin, not account admin) can reach the Audit
      Trail the bonus describes, and the agent's changes show as made by that user. Reviewer
      feedback suggests "Project Settings → Audit Trail" may not match the UI.
- [ ] **Approval button**: the approver is the person who ran the pipeline
      (`disallowPipelineExecutor: false` in the solve template).

### Customer network pre-flight (send 1 week ahead)

Students need only Instruqt. Harness runs inside the Instruqt virtual browser, and the
**Your App** tab is proxied by Instruqt too. Ask the customer's IT to allow, and to test with an
invite link:

- `play.instruqt.com` and `*.instruqt.com`, including websockets

The **Harness (new window)** escape route skips the virtual browser, so it also needs:

- `app.harness.io` and `university-identity.harness.io` (the Keycloak sign-in page)
- Private browsing allowed in their managed browser. Banks often turn off Chrome Incognito and Edge
  InPrivate by policy. If it's off, students sign out of their own Harness account instead (below)

Plan B: guest Wi-Fi or hotspots.

### Say this at kickoff

Anyone who uses Harness at work is probably signed in to app.harness.io already. The embedded
Harness tab doesn't care, but the **Harness (new window)** tab would open their own session and
show "You are not authorized to access Next Gen". Before launching the track, they either:

- **A (recommended).** Open the invite link in a private/incognito window and stay in it for the
  whole workshop. Their work session is untouched.
- **B.** Sign out of their own Harness account in their normal browser.

### Instruqt

- `instruqt track validate se-workshop-sda`
- `instruqt track test --skip-fail-check se-workshop-sda` (runs every setup → solve → check)
- Hot-start pool: attendees + 10%, started 30 minutes before kickoff
- Don't push or deploy the track without the track owner's OK

---

## Lab by lab

### Lab 0: Log in
SSO with the credentials on the **Lab Credentials** tab, then select the project named in the
assignment. **Stuck:** credentials tab blank → wait 30 s and refresh it; it's written by setup.

### Lab 1: Brand your app
Students edit `showcase.yaml` on a branch, open a PR, use the AI summary, and squash-merge.
**Check:** main differs from the seed, the file is valid (same rules as the app's Go
validation), and a merged PR exists.
**Common miss:** an unquoted `accent: #D7282F`. YAML reads it as a comment, and Check says so.
**Emoji:** the browser editor can't type emoji, so `emoji` takes a standard name (`fire`, `tada`,
`chart`; the full list is `internal/brand/emoji.json`). Check flags a name the app doesn't know.
**Talk track:** the AI summary is the first agent touchpoint: it writes the PR description for you.

### Lab 2: Build with the agent
The agent creates the `showcase` pipeline: Run step (`go test`) + Build and Push to HAR. The
first run fails on purpose: `internal/market/market.go` line 33 uses `HasPrefix(s, "JPY")`;
yen pairs end with JPY, so the fix is `HasSuffix`. Analyze Error should find it.
**Check:** a CI stage with Run and BuildAndPush steps, a green run, and tags in the student's
registry. **Common miss:** the agent names the pipeline differently. Check accepts the only
pipeline in the project, but later Skips assume `showcase`; have them ask the agent to rename.

### Lab 3: Deploy with the agent
Three prompts: Environment + Infrastructure, Service, then a rolling Deploy stage. The manifests
are in the repo under `deploy/`; the image and pull secret come from `<+artifacts.primary.*>`,
and HAR pull credentials are generated per run.
**Check:** `showcase`, `dev`, `k8s_dev` exist; a Deployment stage succeeded; the app's
`/health` returns 200 on the VM's NodePort (30080).
**Talk track:** point at the pod strip at the bottom of the app; the next lab uses it.

### Lab 4: Ship safely
The agent converts Deploy to canary: canary deploy (1 pod) → health check → canary delete →
rolling deploy → health check; rollback is canary delete + rolling rollback. Students ship a
good release, then `release.healthy: false`. That build's `/health` returns 503 while `/ready`
stays 200, so pods go Ready and the health check (20 calls through the Service) fails in
seconds. The stage rolls back; only the canary ever ran the bad version.
**Check:** the pipeline has a canary, one green canary run, one rolled-back run, and a healthy
app. **Skip** ships 1.2.0 and the bad 1.3.0 (two pipeline runs, about 10 minutes); Lab 5's setup
fixes main forward.

### Lab 5: Guardrails
Setup switches on the `guardrails` policy set (policy `deploy_needs_approval`: every Deployment
stage needs a prior Approval stage or a Harness Approval step) and, if main still has
`healthy: false`, fixes it forward. The first run is denied. The agent adds an "Approve release"
step; the student runs, approves, and ships. Students **view** the policy (Project Settings →
Policies) but never write Rego: this is an intro workshop with a mixed audience.
**Check:** policy set on, approval before deploy, and a green run since the lab started.

### Bonus
Audit trail, "explain this run", and extend prompts. No Check.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| Harness (new window) says "You are not authorized to access Next Gen" | The student's own browser is already signed in to app.harness.io as a different user | Open the tab's link in a private/incognito window and sign in with the Lab Credentials |
| Check says it can't find an entity | The agent used a different identifier | Ask the agent to rename it, or Skip |
| Build fails pushing to HAR | Wrong connector or repository in the step | Connector `har`, repository `<+variable.image_repo>` |
| Deploy fails pulling the image | Service artifact path is wrong | Path must be the Lab 3 `IMAGE_PATH`, tag `<+pipeline.sequenceId>` |
| Your App tab blank or a proxy error | No deploy has succeeded yet, or pods are still starting | Wait 30 s and click the tab's refresh icon. Before Lab 3 there's nothing to show |
| Health check fails on a "good" release | `release.healthy` left false | Set it true, bump version, rerun |
| Health check shows `HTTP 000`, and the "Checking …" line names a delegate other than `<project>-delegate` (for example the account-level `chaos-delegate`) | The step ran on a delegate outside this sandbox, which can't resolve its k3s DNS. Each lab's setup pins the pipeline to `<project>-delegate`, but the agent may have removed that line | Ask the agent to set the pipeline's delegate selector to `<project>-delegate`, then rerun. Or Skip |
| Rolling deploy fails: `spec.selector ... field is immutable` | Someone removed `harness.io/track: stable` from `deploy/manifests/deployment.yaml` (it's there so the switch from rolling to canary works) | Put the label back, or delete the `showcase` Deployment in the namespace and rerun |
| App flaps between healthy and 503 after a rollback | The agent's canary has no Canary Delete in its rollback steps, so the bad canary pod stays behind the Service | Ask the agent to add Canary Delete to the rollback steps, then rerun |
| Lab 5 run never asks for approval | Approval step not in the Deploy stage | Ask the agent again, or Skip |
| Any lab hopelessly stuck | — | Skip. Every solve is idempotent and leaves the next lab's start state |

---

## What setup provisions (per sandbox)

Track setup (`track_scripts/setup-sandbox`): Keycloak user, Harness project, a namespace and
delegate on the VM's k3s, then `tofu apply` of `assets/terraform/sda-workshop/`:

- Harness Code repo `sda-showcase` (seeded by git push from `assets/app/`)
- HAR registry (identifier = project), service account `har_robot` + token secret, Docker
  connector `har`
- Kubernetes connector `workshop_k8s` (inherits from the delegate)
- Project variables `sandbox_id` and `image_repo`
- OPA policy `deploy_needs_approval` and policy set `guardrails` (created **disabled**)

Labs 3, 4, 5 and the bonus start by adding `delegateSelectors: [<project>-delegate]` at pipeline level
(`pin_delegate` in `sda_checks.py`). The agent doesn't reliably set selectors on Shell Script steps,
and without one a step can land on an account-level delegate such as `chaos-delegate`, which can't
reach the sandbox's k3s. Harness Cloud CI stages ignore the selector.

Cleanup deletes the Keycloak user and the project. The namespace, delegate and app go away with the VM.

## Reusing this for another customer

The track is customer-neutral. Tailor the kickoff and wrap slides, and say the customer's own
deploy story during Lab 4's "rollback" moment. To add an app flavor, add `web/<flavor>.html` and
the name to `brand.Flavors` in the app, and to `FLAVORS` in `assets/lib/sda_checks.py`.
