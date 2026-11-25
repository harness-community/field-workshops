---
slug: guardrails
id: f9jeiapupyh2
type: challenge
title: "\U0001F46E Lab 5: Guardrails"
teaser: A policy blocks your deploy. Have the agent make the pipeline compliant, then
  approve the release yourself
tabs:
- id: vdhdz2ff6o8t
  title: Harness
  type: browser
  hostname: harness
- id: 0t8tjg5exmce
  title: Your App
  type: service
  hostname: sandbox
  port: 30080
- id: ralfthaqmnyo
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: 64d3p4hxb6ms
  title: Harness (new window)
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
difficulty: intermediate
timelimit: 600
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Lab 5: Guardrails</h2>
<hr class="cyan">
<br>

The last part of the outer loop is **governance**: rules that apply to every change, every time.
An agent that builds and ships on its own needs guardrails it can't talk its way around. Your
platform team has just switched on a policy for your project: **every deployment needs an approval
step.** It applies to every pipeline, whether a person or the agent wrote it.

Get blocked
===

1) Run the **showcase** pipeline
2) It fails before any stage starts. Open the run and read the **policy evaluation**: the policy
   `deploy_needs_approval` denied it, and it says why

See the rule
===

1) Go to **Project Settings** → **Policies** and open **Deploys need an approval**
2) You don't need to read the code. The comment at the top says what it does in plain English: a
   deployment is allowed only if a human approval comes first

> [!NOTE]
> Your platform team writes a rule like this once, in Rego (Open Policy Agent). Harness stores and
> versions it, and checks every pipeline against it on every run.

Make it compliant
===

1) Click **Ask AI** and start a **new chat**
2) Copy this prompt:

```
In the showcase pipeline, add a Harness Approval step named "Approve release" as the first step of the Deploy stage. The approvers are the user group All Project Users, with a minimum of 1 approval, and the person who ran the pipeline may approve. Time out after 1 hour.
```

3) Review and accept

Approve your release
===

1) Run the pipeline. This time the policy passes
2) When the run pauses at **Approve release**, click **Approve**
3) The canary rolls out as before. Check the **Your App** tab

> [!NOTE]
> **Policy as code is what makes an autonomous SDLC safe.** The agent rewrote the pipeline to
> comply, and OPA checked that change the same way it checks every change. The rules travel with
> every pipeline, whoever or whatever wrote it.

<!-- yaml-backup:start -->
<details>
<summary>Agent stuck? Use the backup pipeline YAML</summary>

If the agent can't add the approval after a couple of tries, open **Pipelines** → **showcase**, switch from **Visual** to **YAML** at the top, click **Edit YAML** if it's read-only, replace everything with the YAML below, and click **Save**. Then pick up the lab where you left off.

```yaml
pipeline:
  name: showcase
  identifier: showcase
  orgIdentifier: [[ Instruqt-Var key="HARNESS_ORG_ID" hostname="sandbox" ]]
  projectIdentifier: [[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]
  # Every delegate task runs on the student's own delegate (Harness Cloud CI ignores this).
  delegateSelectors:
    - [[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]-delegate
  tags: {}
  properties:
    ci:
      codebase:
        repoName: sda-showcase
        build:
          type: branch
          spec:
            branch: main
  stages:
    - stage:
        name: Build
        identifier: Build
        type: CI
        spec:
          cloneCodebase: true
          platform:
            os: Linux
            arch: Amd64
          runtime:
            type: Cloud
            spec: {}
          execution:
            steps:
              - step:
                  type: Run
                  name: Unit tests
                  identifier: Unit_tests
                  spec:
                    shell: Sh
                    image: golang:1.27-alpine
                    command: go test ./...
              - step:
                  type: BuildAndPushDockerRegistry
                  name: Build and push to HAR
                  identifier: Build_and_push_to_HAR
                  spec:
                    connectorRef: har
                    repo: <+variable.image_repo>
                    tags:
                      - <+pipeline.sequenceId>
    - stage:
        name: Deploy
        identifier: Deploy
        type: Deployment
        spec:
          deploymentType: Kubernetes
          service:
            serviceRef: showcase
          environment:
            environmentRef: dev
            deployToAll: false
            infrastructureDefinitions:
              - identifier: k8s_dev
          execution:
            steps:
              - step:
                  type: HarnessApproval
                  name: Approve release
                  identifier: Approve_release
                  timeout: 1h
                  spec:
                    approvalMessage: Release <+pipeline.sequenceId> of showcase to dev. Approve?
                    includePipelineExecutionHistory: true
                    isAutoRejectEnabled: false
                    approvers:
                      userGroups:
                        - _project_all_users
                      minimumCount: 1
                      disallowPipelineExecutor: false
                    approverInputs: []
              - step:
                  type: K8sCanaryDeploy
                  name: Canary deploy
                  identifier: Canary_deploy
                  timeout: 10m
                  spec:
                    instanceSelection:
                      type: Count
                      spec:
                        count: 1
                    skipDryRun: false
              - step:
                  type: ShellScript
                  name: Canary health check
                  identifier: Canary_health_check
                  timeout: 3m
                  spec:
                    shell: Bash
                    onDelegate: true
                    # Pin the student's own delegate. Without a selector Harness may pick any
                    # delegate in the account, and cluster DNS only resolves on this cluster.
                    delegateSelectors:
                      - [[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]-delegate
                    source:
                      type: Inline
                      spec:
                        script: |-
                          # Every pod answers through the Service, the canary included. Any
                          # unhealthy answer fails the step and the stage rolls back.
                          url="http://showcase.<+infra.namespace>.svc.cluster.local/health"
                          echo "Checking $url from $(hostname)"
                          for i in $(seq 1 20); do
                            code=$(curl -s -o /tmp/health -w '%{http_code}' --max-time 3 "$url")
                            # 000 means no connection yet (endpoints still settling): retry briefly
                            tries=0
                            while [ "$code" = "000" ] && [ $tries -lt 5 ]; do
                              sleep 2; tries=$((tries + 1))
                              code=$(curl -s -o /tmp/health -w '%{http_code}' --max-time 3 "$url")
                            done
                            echo "check $i: HTTP $code $(cat /tmp/health 2>/dev/null)"
                            if [ "$code" != "200" ]; then
                              echo "Unhealthy release: rolling back"
                              exit 1
                            fi
                            sleep 1
                          done
                          echo "20 of 20 health checks passed"
                    environmentVariables: []
                    outputVariables: []
              - step:
                  type: K8sCanaryDelete
                  name: Canary delete
                  identifier: Canary_delete
                  timeout: 10m
                  spec: {}
              - step:
                  type: K8sRollingDeploy
                  name: Rolling deploy
                  identifier: Rolling_deploy
                  timeout: 10m
                  spec:
                    skipDryRun: false
                    pruningEnabled: false
              - step:
                  type: ShellScript
                  name: Health check
                  identifier: Health_check
                  timeout: 3m
                  spec:
                    shell: Bash
                    onDelegate: true
                    # Pin the student's own delegate. Without a selector Harness may pick any
                    # delegate in the account, and cluster DNS only resolves on this cluster.
                    delegateSelectors:
                      - [[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]-delegate
                    source:
                      type: Inline
                      spec:
                        script: |-
                          # Every pod answers through the Service, the canary included. Any
                          # unhealthy answer fails the step and the stage rolls back.
                          url="http://showcase.<+infra.namespace>.svc.cluster.local/health"
                          echo "Checking $url from $(hostname)"
                          for i in $(seq 1 20); do
                            code=$(curl -s -o /tmp/health -w '%{http_code}' --max-time 3 "$url")
                            # 000 means no connection yet (endpoints still settling): retry briefly
                            tries=0
                            while [ "$code" = "000" ] && [ $tries -lt 5 ]; do
                              sleep 2; tries=$((tries + 1))
                              code=$(curl -s -o /tmp/health -w '%{http_code}' --max-time 3 "$url")
                            done
                            echo "check $i: HTTP $code $(cat /tmp/health 2>/dev/null)"
                            if [ "$code" != "200" ]; then
                              echo "Unhealthy release: rolling back"
                              exit 1
                            fi
                            sleep 1
                          done
                          echo "20 of 20 health checks passed"
                    environmentVariables: []
                    outputVariables: []
            rollbackSteps:
              - step:
                  type: K8sCanaryDelete
                  name: Canary delete
                  identifier: Rollback_canary_delete
                  timeout: 10m
                  spec: {}
              - step:
                  type: K8sRollingRollback
                  name: Rolling rollback
                  identifier: Rolling_rollback
                  timeout: 10m
                  spec:
                    pruningEnabled: false
        failureStrategies:
          - onFailure:
              errors:
                - AllErrors
              action:
                type: StageRollback
```
</details>
<!-- yaml-backup:end -->

Click **Check** when your approved release is live.
