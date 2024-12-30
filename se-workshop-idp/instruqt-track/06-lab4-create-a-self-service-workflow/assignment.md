---
slug: lab4-create-a-self-service-workflow
id: ya61nfoj1xhy
type: challenge
title: Lab 4 - Create a Self-Service Workflow
teaser: Standing up a new service often results in tickets flowing back and forth
  across the organization. Eliminate the work management overhead with a process automation.
notes:
- type: text
  contents: |-
    <h1>Service Onboarding</h1>

    <img src="https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_Pipeline.svg" width="500" style="display: inline; vertical-align: left;">
    <img src="https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_Serving_Image.svg" width="300" style="display: inline; vertical-align: right;">

    - **Initiate new projects and services in minutes**
    - **Build Software Templates with best practices baked in**
    - **Create self-service flows and avoid hundreds of tickets**
tabs:
- id: kyi862q9cdh0
  title: Harness Platform
  type: browser
  hostname: harness
- id: ydmdqanzdoow
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: m452fjjqlo3y
  title: Shell
  type: terminal
  hostname: sandbox
- id: hx1jdikngbnj
  title: GitHub
  type: website
  url: https://github.com/orgs/harnessworkshop/repositories
  new_window: true
- id: wklfjgzqdu68
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
</style><h2 class="cyan">Create a Self-Service Workflow</h2>
<hr class="cyan">
<br><br>

> ## Switch to the [button label="Code Editor" variant="success"](tab-1) tab to continue

### Open and review the contents of the `onboard-new-app.yaml`
> [!IMPORTANT]
> Take time to understand the template yaml and the orchestration behind the template.


> [!NOTE]
> - *At a high-level, what do you think this workflow does?*


> ## Switch to the [button label="Harness Platform" variant="success"](tab-0) tab to continue

## Now it's time to execute an IDP Workflow

Click on **Workflows** in the left Nav <br>

> **Workflows** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_workflow_provision_new_app_pattern.png)
> - Click `Service Onboarding`
> - **Provision a New Application Pattern**
>   - Click `Execute` and provide the details below ↓

> **Provision a New Application Pattern**
> - **Fill in the repo details**
>   - Repo Name: <pre>`teama-[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]`</pre>
>   - App Description: <pre>`My new application`</pre>
>   - Owner: `TeamA`
>   - Click on `Review`
> - Click `Create`

> You will be directed to the **Workflow Run** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_workflow_run.png)
> - Click `Show Logs`
> - Then click on the link in the logs to view the pipeline execution
> - Once the pipeline is completed, click on the [button label="GitHub" variant="success"](tab-3) tab
> - This will open a new window and take you to the `harnessworkshop` organization in **GitHub**
> - From here we can validate that our new repository was generated
> - View the contents of your auto generated repository!
> ***It’s magic!***


> ## Switch to the [button label="Harness Platform" variant="success"](tab-0) tab to continue

> In the left Nav <br>
> - Head back to the **IDP Module**
> - Click on **Catalog**
> - Select your newly created service
>   - You can use the filter to narrow down the list if needed
>     - Filter: <pre>`teama-[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]`</pre>

> [!NOTE]
> This service was automatically created and registered for you!
> - *What features do you expect to see in your newly created service?*

## Congratulations! You have successfully onboarded a new app via a self-service workflow!

===============

Click the **Check** button to continue.
