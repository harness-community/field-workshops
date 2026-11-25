---
slug: cd-frontend
id: u1zmd9d4tcwd
type: challenge
title: 'Optional: Deploy the frontend (click Skip)'
teaser: Not covered in the live session. Click Skip and we will set this up for you.
  Your lab stays open afterward so you can come back and try it.
notes:
- type: text
  contents: |
    ## Optional: Deploy the frontend
    Not covered in the live session. Click **Skip** and we will set this up for you.

    Your lab stays open after the session if you want to come back and try it.
tabs:
- id: sf1do64c4ncq
  title: Harness Platform
  type: browser
  hostname: harness
- id: cwdi3omdysvu
  title: Demo App
  type: website
  url: https://${_SANDBOX_ID}.instruqt.harness-demo.site/
- id: nqimuy2n2wyt
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: zootftk9wty8
  title: Shell
  type: terminal
  hostname: sandbox
- id: ja8jhtlrl9ne
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
</style><h2 class="cyan">Continuous Deployment - Frontend</h2>
<hr class="cyan">
<br><br>

## Time to deploy our new artifact
> Go back to the **Harness** `Pipeline Studio` by clicking the **Edit Pipeline** button at the top of the screen \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_edit.png)

> 1) Click `+Add Stage`
> 1) Choose **Deploy** stage type \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_stage_deploy.png)
> 1) Configure with the details below ↓

> **Deploy Stage**
> - Stage Name: <pre>`Frontend - Deployment`</pre>
> - Deployment Type: `Kubernetes`
> - Click **Set Up Stage**

> - On the **Service** tab \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_tab_service.png)
>    1) Click `+ Add Service`
>    1) Configure with the details below ↓

> **New Service**
> - ***About the Service***
>   - Name: <pre>`frontend`</pre>
>   - Store: `Inline`
> - ***Service Definition***
> - Deployment Type: `Kubernetes`
> - Manifests: `+ Add Manifest`
>   - ***Manifest***
>     1) Manifest Type: `K8s Manifest`
>        - Click **Continue >**
>     1) Manifest Source: `Code`
>        - Click **Continue >**
>     1) Manifest Details
>        -  Manifest Identifier: <pre>`templates`</pre>
>        -  Repository Name: `[[ Instruqt-Var key="HARNESS_REPO" hostname="sandbox" ]]`
>        -  Branch: <pre>`main`</pre>
>        -  File/Folder Path: <pre>`harness-deploy/frontend/manifests`</pre>
>        -  Values.yaml:
>           - Click `+ Add File`
>           <pre><code>harness-deploy/frontend/values.yaml</code></pre>
>        - Click **Submit >**
> - Artifacts: `+ Add Artifact Source`
>   - ***Artifact***
>     1) Artifact Repository Type: `Google Artifact Registry`
>     2) Artifact Repository: `workshop-gar`
>     3) Artifact Location
>        -  Artifact Source Identifier: <pre>`frontend`</pre>
>        -  Project Id: <pre>`seworkshop`</pre>
>        -  Region: `us`
>        -  Repository Name: <pre>`seworkshop`</pre>
>        -  Package: <pre>`harness-workshop`</pre>
>        -  Version: <pre><code><+variable.username>-<+pipeline.sequenceId></code></pre> \
>            (change the field type to expression) \
>            ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/change_input_expression.png)
>     - Click **Submit >**
>   - Click **Save**
> - Click **Continue >**

> - On the **Environment** tab \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_tab_environment.png)
>    1) Specify Environment: `Dev`
>    1) Specify Infrastructure: `K8s Dev`

> [!NOTE]
> With Harness, a platform team can easily create and manage environments and infrastructure, then developers can use them to deploy their applications.

> - On the **Execution** tab \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_tab_execution.png)
>    1) Select: `Rolling` \
>       ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/deploy_rolling.png)
>    1) Click **Use Strategy**

> [!NOTE]
> The frontend is a static application so there isn't a need for `Canary` or `Blue/Green` at this time. <br>
> In the next Lab we will use the `Canary` release strategy for our backend service.

### Execute your Pipeline
> Click **Save** in the top right to save your pipeline. \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_save.png)

> Now click **Run** to execute the pipeline \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_run.png)
> Then click **Run Pipeline** \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-devsecops/assets/images/pipeline_run_pipeline.png)

> The build should run using: <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/unscripted/unscripted_lab3_execution.png)
> - Branch Name: `main`
> - Stage: **Frontend - Deployment**
>   - Primary Artifact: `frontend`

===============

Click the **Check** button to continue.
