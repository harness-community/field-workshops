---
slug: cd-backend
id: fewv39aranqw
type: challenge
title: Lab 3 - Continuous Deployment - Backend
teaser: Deploy the backend of your application, configuring pipelines with advanced
  deployment strategies like Canary and Blue/Green.
notes:
- type: text
  contents: |-
    <style>
      .container {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        justify-content: center;
        height: 90vh;
        gap: 10px;
        padding: 5px;
        box-sizing: border-box;
      }

      .harness-image {
        max-width: 90%;
        max-height: 65%;
        object-fit: contain;
      }

      .features-list {
        list-style-type: none;
        padding: 0;
        position: sticky;
      }

      .features-list li {
        margin: 5px 0;
        font-weight: bold;
        font-size: 25px;
      }

      @media (max-width: 768px) {
        .features-list li {
          font-size: 1.25rem;
        }
      }

      @media (max-width: 480px) {
        .features-list li {
          font-size: 1rem;
        }
    </style>

    <div class="container">
      <h1>Any app anywhere, no scripting</h1>
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/cd_deploy_anywhere_static.png">
      <ul class="features-list">
        <li>Target any cloud</li>
        <li>Canary, Blue Green or Rolling Deployment</li>
        <li>No scripting required</li>
      </ul>
    </div>
tabs:
- id: xpnbnnyrqdty
  title: Harness Platform
  type: browser
  hostname: harness
- id: kviafrp0dyzo
  title: Demo App
  type: website
  url: https://${_SANDBOX_ID}.instruqt.harness-demo.site/
- id: pznxkw45dnum
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: a9ovmqyfg3bq
  title: Shell
  type: terminal
  hostname: sandbox
- id: bmaimvljhqkm
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
difficulty: basic
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
