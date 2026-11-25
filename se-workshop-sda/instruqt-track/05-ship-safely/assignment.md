---
slug: ship-safely
id: 071uejavpbai
type: challenge
title: "\U0001F6E1️ Lab 4: Ship Safely"
teaser: Switch to a canary with a health check, then ship a bad release and watch
  it roll itself back
tabs:
- id: 2yk8gpgmjr8t
  title: Harness
  type: browser
  hostname: harness
- id: lmobosjki3zm
  title: Your App
  type: service
  hostname: sandbox
  port: 30080
- id: wgpyicu76rjf
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: mpbhtpk8pk5i
  title: Harness (new window)
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
difficulty: intermediate
timelimit: 1200
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Lab 4: Ship Safely</h2>
<hr class="cyan">
<br>

**Welcome to the outer loop.** In Labs 1 to 3 you got your code built and running, and most
delivery tools can get you that far. The outer loop is everything that happens once code leaves a
developer's hands: releasing it safely, catching a bad release, and following the rules on every
change. That's where Harness stands apart, and it's what the rest of this workshop is about.

A rolling deploy replaces every pod, healthy or not. A **canary** tries the new version on one
pod first, checks its health, and only then rolls it out to everything. If the check fails,
Harness rolls back on its own, and nobody gets paged.

Ask for a canary
===

1) Click **Ask AI** and start a **new chat**
2) Copy this prompt:

```
In the showcase pipeline, change the Deploy stage to a canary deployment with these steps, in order:
1. A Canary Deployment step named "Canary deploy" with 1 instance
2. A Shell Script step named "Canary health check" with a 3 minute timeout, using the script below
3. A Canary Delete step named "Canary delete"
4. A Rolling Deployment step named "Rolling deploy"
5. A Shell Script step named "Health check" with a 3 minute timeout, using the same script

Rollback steps: a Canary Delete step, then a Rolling Rollback step. If any step fails, roll back the stage.

The script:
url="http://showcase.<+infra.namespace>.svc.cluster.local/health"
echo "Checking $url from $(hostname)"
for i in $(seq 1 20); do
  code=$(curl -s -o /dev/null -w '%{http_code}' --max-time 3 "$url")
  echo "check $i: HTTP $code"
  [ "$code" = "200" ] || { echo "Unhealthy release"; exit 1; }
  sleep 1
done
```

3) Review and accept. Open the **Deploy** stage's **Execution** tab and look at the steps, and at the **Rollback** side

> [!NOTE]
> The health check hits your app's `/health` endpoint 20 times through the Kubernetes Service.
> With one canary pod among four, a bad canary is all but certain to be caught.

Ship a good release
===

1) In **Code Repository** → **sda-showcase**, edit `showcase.yaml`: change your `message` or
   `tagline`, and bump `version` (for example `1.1.0` → `1.2.0`). Commit straight to `main`
2) Run the **showcase** pipeline
3) Watch the **Your App** tab while **Canary deploy** runs: a pod on the new version appears in the
   strip at the bottom. Then the rolling deploy takes over, and the page announces the new release

Ship a bad release
===

Now pretend somebody ships a release that starts fine but can't serve traffic.

1) Edit `showcase.yaml` again. Bump `version` to `1.3.0` and set:
   ```
   release:
     healthy: false
   ```
2) Commit to `main` and run the pipeline
3) Watch the **Canary health check** fail and the stage **roll back**. Only the canary ever ran the
   bad version. Your app stays on 1.2.0 the whole time: check the **Your App** tab
4) Click the failed **Canary health check** step and click **Analyze Error**. What does AI say happened?

> [!NOTE]
> **This is what most scripted deploys can't do:** detect a bad release in seconds, before it
> reaches every pod, and undo it with no human in the loop.

Put it right
===

Set `healthy: true`, bump `version` to `1.3.1`, commit, and run the pipeline. This time the
canary passes and 1.3.1 rolls out.

<!-- yaml-backup:start -->
<details>
<summary>Agent stuck? Use the backup pipeline YAML</summary>

If the agent can't get the canary right after a couple of tries, open **Pipelines** → **showcase**, switch from **Visual** to **YAML** at the top, click **Edit YAML** if it's read-only, replace everything with the YAML below, and click **Save**. Then pick up the lab where you left off.

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

Click **Check** once you've had a green canary run and a rollback.
