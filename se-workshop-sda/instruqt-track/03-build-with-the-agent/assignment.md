---
slug: build-with-the-agent
id: dunweumlrzp2
type: challenge
title: "\U0001F3D7️ Lab 2: Build with the Agent"
teaser: Have the agent write your CI pipeline, then let AI explain why the first build
  failed
tabs:
- id: rwvgbmefo2s7
  title: Harness
  type: browser
  hostname: harness
- id: sa3koh4fuyfb
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: ftbmabb3mqxy
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
</style><h2 class="cyan">Lab 2: Build with the Agent</h2>
<hr class="cyan">
<br>

Your change is merged, but nothing ships it yet. In this lab you won't click through a pipeline
editor. You'll ask the **Software Delivery Agent** for a pipeline in plain English, review what
it proposes, and accept it.

The pipeline will:
1. Run the app's unit tests
2. Build a container image
3. Push it to **your own Harness Artifact Registry**, which is already set up for you

Ask the agent for a CI pipeline
===

1) Click the **Ask AI** button at the bottom right of the Harness screen
2) Copy this prompt into the chat. Keep the names exactly as written: later labs look for them.

```
Create a pipeline named "showcase" with the identifier showcase. Its codebase is the sda-showcase repository in Harness Code, building the main branch.

Add a CI stage named "Build" that runs on Harness Cloud (Linux, AMD64) with two steps:
1. A Run step named "Unit tests" that uses the image golang:1.27-alpine and runs: go test ./...
2. A "Build and Push to Docker Registry" step named "Build and push to HAR" that uses the connector "har", the repository <+variable.image_repo>, and the tag <+pipeline.sequenceId>.
```

3) Read the proposal. The agent shows you the pipeline before it creates anything
4) Accept it, then open the pipeline from **Pipelines** → **showcase**

> [!NOTE]
> `<+variable.image_repo>` is a project variable that points at your registry, and
> `<+pipeline.sequenceId>` is the run number. Every build gets its own image tag.

> [!IMPORTANT]
> If the agent picks different names, or leaves a step out, just tell it what to fix, as you
> would a colleague. For example: *"Rename the pipeline to showcase."*

Run it, and watch it fail
===

1) Click **Run**, then **Run Pipeline**
2) The **Unit tests** step fails. That's on purpose: a bug was hiding in the code before you got here

Find the bug
===

> [!IMPORTANT]
> The bug is in `internal/market/market.go`. That's the only file you need to change.

1) Click the failed **Unit tests** step and read the test output: which test failed, what did it
   expect, and what did it get?
2) Click **Analyze Error** for a second opinion. AI reads the log and the code
3) Open `internal/market/market.go` and find the line that explains the failure

<details>
<summary>Stuck? Click for the answer</summary>

The test expects yen pairs such as `USDJPY` to be quoted to 2 decimal places. In
`internal/market/market.go`, line 33 checks whether the symbol **starts** with `JPY`. Yen pairs
**end** with `JPY`, so the check should be `strings.HasSuffix(s, "JPY")`.
</details>

Fix it and go green
===

1) Go to **Code Repository** → **sda-showcase** → `internal/market/market.go`, then click **Edit**
2) Fix the bug
3) Click **Commit changes** and commit straight to `main`
4) Run the **showcase** pipeline again. Tests pass, the image builds, and it's pushed to your registry
5) Open **Artifact Registries** in the left navigation and find the `sda-showcase` image, tagged with your run number

> [!NOTE]
> **What just happened:** the agent wrote the pipeline, and AI helped you diagnose the failure.
> You reviewed both, and you made the call each time.

<!-- yaml-backup:start -->
<details>
<summary>Agent stuck? Use the backup pipeline YAML</summary>

If the agent can't get the pipeline right after a couple of tries, paste this instead. If there's no **showcase** pipeline yet, click **Pipelines** → **Create a Pipeline**, name it `showcase`, and click **Start**. Then switch from **Visual** to **YAML** at the top, replace everything with the YAML below, and click **Save**. Then pick up the lab where you left off.

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
```
</details>
<!-- yaml-backup:end -->

Click **Check** when your pipeline has a green run.
