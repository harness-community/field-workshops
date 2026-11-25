---
slug: deploy-with-the-agent
id: nkim9wyuvgzz
type: challenge
title: "\U0001F680 Lab 3: Deploy with the Agent"
teaser: Have the agent model your service, environment and cluster, then ship your
  app live
tabs:
- id: y64hptxjz3pi
  title: Harness
  type: browser
  hostname: harness
- id: xkaymrvkrikt
  title: Your App
  type: service
  hostname: sandbox
  port: 30080
- id: he5dag6wrnhx
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: kcaj2agug6as
  title: Harness (new window)
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
difficulty: basic
timelimit: 1500
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Lab 3: Deploy with the Agent</h2>
<hr class="cyan">
<br>

Your image is in the registry. Now you ship it to Kubernetes. Harness models a deployment with
three building blocks, and the agent will create all of them:

| Block | What it answers | Yours |
|---|---|---|
| **Service** | *What* are we deploying? Manifests plus an image | `showcase` |
| **Environment** | *Where*, logically? | `dev` |
| **Infrastructure** | *Where*, physically? Cluster plus namespace | `k8s_dev` |

A Kubernetes cluster connector, `workshop_k8s`, is already set up for you.

Ask for the environment and infrastructure
===

1) Click **Ask AI** and start a **new chat**
2) Copy this prompt:

```
Create a PreProduction environment named "dev" with the identifier dev.

In that environment, create a Kubernetes infrastructure definition named "k8s_dev" with the identifier k8s_dev. It uses the Kubernetes connector "workshop_k8s", the namespace <+project.identifier>, and the release name release-<+INFRA_KEY_SHORT_ID>.
```

3) Review the proposal and accept it

Ask for the service
===

Copy this prompt into the same chat:

```
Create a Kubernetes service named "showcase" with the identifier showcase.

Manifests: a K8sManifest named "showcase" stored in the Harness Code repository sda-showcase, branch main, with the manifest folder deploy/manifests and the values file deploy/values.yaml.

Primary artifact: a Docker Registry artifact named "showcase" using the connector "har", the image path [[ Instruqt-Var key="IMAGE_PATH" hostname="sandbox" ]], and the tag <+pipeline.sequenceId>.
```

Review and accept

> [!NOTE]
> The manifests live **in your repo**, next to the code, in `deploy/`. Take a look at
> `deploy/values.yaml`: the image and pull secret come from `<+artifacts.primary...>`, so Harness
> fills in exactly the image this run built.

Add a deploy stage
===

Copy this prompt:

```
In the showcase pipeline, add a Deployment stage named "Deploy" after the Build stage. It deploys the service showcase to the environment dev and the infrastructure k8s_dev, using a Rolling deployment. If the stage fails, roll it back.
```

1) Review and accept, then open the **showcase** pipeline. You now have two stages: **Build** → **Deploy**
2) Click **Run**, then **Run Pipeline**
3) Watch the **Deploy** stage: Harness fetches your manifests, fills in the image, and rolls out 3 pods

See it live
===

Open the **Your App** tab. That's your branding from Lab 1, built in Lab 2, and running now in
Kubernetes. If the page is blank, give it a few seconds and click the refresh icon on the tab.

> [!NOTE]
> Look at the strip along the bottom of the page: it shows which pods are answering and what
> version each one runs. Keep it in mind for the next lab.

<!-- yaml-backup:start -->
<details>
<summary>Agent stuck? Use the backup pipeline YAML</summary>

If the agent can't get the Deploy stage right after a couple of tries, open **Pipelines** → **showcase**, switch from **Visual** to **YAML** at the top, click **Edit YAML** if it's read-only, replace everything with the YAML below, and click **Save**. Then pick up the lab where you left off. It needs the `showcase` service, the `dev` environment and the `k8s_dev` infrastructure from the first two prompts. If the agent couldn't create those, click **Skip** instead.

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

Click **Check** when your app is live.
