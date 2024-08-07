---
slug: lab3-cd-frontend
id: lwaqwglgt4k9
type: challenge
title: Lab 3 - Continuous Deploy - Frontend
teaser: Deploy the frontend of your application using Harness, setting up deployment
  pipelines, managing environments, and ensuring smooth rollouts.
notes:
- type: text
  contents: |
    - Add a second stage to an existing pipeline
    - Create a k8s service
    - Incorporate an advanced deployment strategy such as Canary
    - Create custom Harness variables
    - Create an Input Set
tabs:
- title: Harness Platform
  type: browser
  hostname: harness
- title: Demo App
  type: website
  url: https://sandbox-8080-${_SANDBOX_ID}.env.play.instruqt.com/
- title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- title: Shell
  type: terminal
  hostname: sandbox
- title: Notes
  type: code
  hostname: sandbox
  path: /root/notes
- title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
difficulty: basic
timelimit: 1600
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Continuous Deploy - Frontend</h2>
<hr class="cyan">
<br><br>

## Time to deploy our new artifact
### Go back to the `Pipeline Studio` and add a `Deployment` stage

Click `+Add Stage` <br>

> Choose **Deploy** stage type <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_stage_deploy.png)

> **Deploy Stage**
> - Stage Name: `Deploy - Frontend`
> - Deployment Type: `Kubernetes`
> - Click **Set Up Stage**

<br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_service.png)
> ### On the  **Service** tab
> - Click `+ Add Service`
> - **New Service**
> - ***About the Service***
>   - Name: `frontend`
>   - Store: `Inline`
> - ***Service Definition***
>   - Deployment Type: `Kubernetes`
>   - Manifests: `+ Add Manifest`
>     - ***Manifest***
>       1) Manifest Type: `K8s Manifest`
>       2) Manifest Source: `Code`
>       3) Manifest Details
>         -  Manifest Identifier: `templates`
>         -  Repository Name: `harnessrepo`
>         -  Branch: `main`
>         -  File/Folder Path: `harness-deploy/frontend/manifests`
>         -  Values.yaml: `+ Add File`
>         -  `harness-deploy/frontend/values.yaml`
>     - Click **Submit >**
>   - Artifacts: `+ Add Artifact Source`
>     - ***Artifact***
>       1) Artifact Repository Type: `Docker Registry`
>       2) Artifact Repository: `workshop-docker`
>       3) Artifact Location
>         -  Artifact Source Identifier: `frontend`
>         -  Image Path: `seworkshop/harness-workshop`
>         -  Tag: `<+variable.username>-<+pipeline.sequenceId>` \
>               (change the field type to expression) \
>               ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/change_input_expression.png)
>     - Click **Submit >**
>   - Click **Save**
> - Click **Continue >**

<br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_environment.png)
> ### On the  **Environment** tab
> - Specify Environment: `dev`
> - Specify Infrastructure: `K8s Dev`
> - Click **Continue >**

<br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_execution.png)
> ### On the  **Execution** tab
> - Select: `Rolling` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/deploy_rolling.png)
> - Click **Use Strategy**

The frontend is a static application so there isn't a need for `Canary` or `Blue/Green` at this time. <br>
In the next Lab we will use the `Canary` release strategy for our backend service.

### Execute your Pipeline
> Click **Save** in the top right to save your pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_save.png)

> Now click **Run** to execute the pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_run.png)

===============

Click the **Check** button to continue.
