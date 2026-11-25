---
slug: cd-backend
id: 0ypzwdgfvgoa
type: challenge
title: 'Optional: Deploy the backend (click Skip)'
teaser: Not covered in the live session. Click Skip and we will set this up for you.
  Your lab stays open afterward so you can come back and try it.
notes:
- type: text
  contents: |
    ## Optional: Deploy the backend
    Not covered in the live session. Click **Skip** and we will set this up for you.

    Next up is Lab 1, the heart of today's session.
tabs:
- id: nfi2dyogxcux
  title: Harness Platform
  type: browser
  hostname: harness
- id: s1fyxztwvr3y
  title: Demo App
  type: website
  url: https://${_SANDBOX_ID}.instruqt.harness-demo.site/
- id: ctzl4p0x8jv5
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: rnmvsoeopqpj
  title: Shell
  type: terminal
  hostname: sandbox
- id: xe9uavuar0mx
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
difficulty: ""
timelimit: 1600
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Continuous Deployment - Backend</h2>
<hr class="cyan">
<br><br>

## Now let's deploy the backend artifact
> Go back to the **Harness** `Pipeline Studio` by clicking the **Edit Pipeline** button \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_edit.png)

> 1) Click `+Add Stage`
> 1) Choose **Deploy** stage type \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_stage_deploy.png)
> 1) Configure with the details below ↓

> **Deploy Stage**
> - Stage Name: <pre>`Backend - Deployment`</pre>
> - Deployment Type: `Kubernetes`
> - Click **Set Up Stage**

> - On the **Service** tab \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_tab_service.png)
>    1) Click `Select Service`
>       1) Select: `backend` \
>        *(this has been preconfigured for you)*
>    1) Click **Continue >**

> - On the **Environment** tab \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_tab_environment.png)
>    1) Click `Propagate Environment From`
>       1) Select: `Stage [Frontend - Deployment]`
>    1) Click **Continue >**

> - On the **Execution** tab \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_tab_execution.png)
>    1) Select: `Canary` \
>       ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/deploy_canary.png)
>    1) Click **Use Strategy**

### Execute your Pipeline
> Click **Save** in the top right to save your pipeline. \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_save.png)

> Now click **Run** to execute the pipeline \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_run.png)
> Then click **Run Pipeline** \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-devsecops/assets/images/pipeline_run_pipeline.png)

> The build should run using: <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/unscripted/unscripted_lab4_execution.png)
> - Branch Name: `main`
> - Stage: **Frontend - Deployment**
>   - Primary Artifact: `frontend`
> - Stage: **Backend - Deployment**
>   - Primary Artifact: `backend`

===============

Click the **Check** button to continue.
