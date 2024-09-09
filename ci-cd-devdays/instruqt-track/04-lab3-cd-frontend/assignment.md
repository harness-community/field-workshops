---
slug: lab3-cd-frontend
id: yfpg43tgfund
type: challenge
title: Lab 3 - Continuous Deployment - Frontend
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
- id: 3bd5xu99a6s1
  title: Harness Platform
  type: browser
  hostname: harness
- id: hxclqcs94fny
  title: Demo App
  type: website
  url: https://sandbox-8080-${_SANDBOX_ID}.env.play.instruqt.com/
- id: ghcwedmqozu4
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: 8gg2aaxwwkqg
  title: Shell
  type: terminal
  hostname: sandbox
- id: ens8pfhhunva
  title: Notes
  type: code
  hostname: sandbox
  path: /root/notes
- id: zfj6lxf2q3y1
  title: Lab Credentials
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
</style><h2 class="cyan">Continuous Deployment - Frontend</h2>
<hr class="cyan">
<br><br>

## Time to deploy our new artifact
### Go back to the `Pipeline Studio` and add a `Deployment` stage

Click `+Add Stage` <br>

> Choose **Deploy** stage type <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_stage_deploy.png)

> **Deploy Stage**
> - Stage Name: <pre>`Frontend - Deployment`</pre>
> - Deployment Type: `Kubernetes`
> - Click **Set Up Stage**

<br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_service.png)
> ### On the  **Service** tab
> - Click `+ Add Service`
> - **New Service**
> - ***About the Service***
>   - Name: <pre>`frontend`</pre>
>   - Store: `Inline`
> - ***Service Definition***
>   - Deployment Type: `Kubernetes`
>   - Manifests: `+ Add Manifest`
>     - ***Manifest***
>       1) Manifest Type: `K8s Manifest`
>       2) Manifest Source: `Code`
>       3) Manifest Details
>         -  Manifest Identifier: <pre>`templates`</pre>
>         -  Repository Name: `harnessrepo`
>         -  Branch: <pre>`main`</pre>
>         -  File/Folder Path: <pre>`harness-deploy/frontend/manifests`</pre>
>         -  Values.yaml: `+ Add File`
>         -  <pre><code>harness-deploy/frontend/values.yaml</code></pre>
>     - Click **Submit >**
>   - Artifacts: `+ Add Artifact Source`
>     - ***Artifact***
>       1) Artifact Repository Type: `Docker Registry`
>       2) Artifact Repository: `workshop-docker`
>       3) Artifact Location
>         -  Artifact Source Identifier: <pre>`frontend`</pre>
>         -  Image Path: <pre>`seworkshop/harness-workshop`</pre>
>         -  Tag: <pre><code><+variable.username>-<+pipeline.sequenceId></code></pre> \
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

> [!NOTE]
> With Harness, a platform team can easily create and manage environments and infrastructure, then developers can use them to deploy their applications.

<br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_execution.png)
> ### On the  **Execution** tab
> - Select: `Rolling` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/deploy_rolling.png)
> - Click **Use Strategy**

> [!NOTE]
> The frontend is a static application so there isn't a need for `Canary` or `Blue/Green` at this time. <br>
> In the next Lab we will use the `Canary` release strategy for our backend service.

### Execute your Pipeline
> Click **Save** in the top right to save your pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_save.png)

> Now click **Run** to execute the pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_run.png)

> The build should run using: <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_lab3_execution.png)
> - Branch Name: `main`
> - Stage: **Frontend - Deployment**
>   - Primary Artifact: `frontend`

===============

Click the **Check** button to continue.
