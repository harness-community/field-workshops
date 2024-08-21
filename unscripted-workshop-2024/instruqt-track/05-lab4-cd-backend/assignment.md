---
slug: lab4-cd-backend
id: iotv0n2ubo46
type: challenge
title: Lab 4 - Continuous Deployment - Backend
teaser: Deploy the backend of your application, configuring pipelines with advanced
  deployment strategies like Canary and Blue/Green.
notes:
- type: text
  contents: |
    - Utilise complex deployment strategies to reduce blast radius of a release
    - Harness makes this easy with Canary and Blue/Green deployment strategies right out of the box
tabs:
- id: s5xfcjae2yck
  title: Harness Platform
  type: browser
  hostname: harness
- id: v0mvjjbmrn52
  title: Demo App
  type: website
  url: https://sandbox-8080-${_SANDBOX_ID}.env.play.instruqt.com/
- id: g6enjuouoygx
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: b5orsmvomcou
  title: Shell
  type: terminal
  hostname: sandbox
- id: mxuch5tpsmxp
  title: Notes
  type: code
  hostname: sandbox
  path: /root/notes
- id: kt31s1ftiumn
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
</style><h2 class="cyan">Continuous Deployment - Backend</h2>
<hr class="cyan">
<br><br>

## Now let's deploy the backend artifact
### Go back to the `Pipeline Studio` and add a `Deployment` stage

Click `+Add Stage` <br>

> Choose **Deploy** stage type <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_stage_deploy.png)

> **Deploy Stage**
> - Stage Name: `Backend - Deployment`
> - Deployment Type: `Kubernetes`
> Click **Set Up Stage**

<br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_service.png)
> ### On the  **Service** tab
> - Click `Select Service`
> - Select: `backend` (this has been preconfigured for us)
> - Click **Continue >**

<br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_environment.png)
> ### On the  **Environment** tab
> - Click `Propagate Environment From`
> - Select: `Stage [Frontend - Deployment]`
> - Click **Continue >**

<br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_execution.png)
> ### On the  **Execution** tab
> - Select: `Canary` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/deploy_canary.png)
> - Click **Use Strategy**

### Execute your Pipeline
> Click **Save** in the top right to save your pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_save.png)

> Now click **Run** to execute the pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_run.png)

> The build should run using: <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_lab4_execution.png)
> - Branch Name: `main`
> - Stage: **Frontend - Deployment**
>   - Primary Artifact: `frontend`
> - Stage: **Backend - Deployment**
>   - Primary Artifact: `backend`

===============

Click the **Check** button to continue.
