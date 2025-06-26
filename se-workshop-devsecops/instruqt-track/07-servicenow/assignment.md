---
slug: servicenow
id: ctsun7qqmerv
type: challenge
title: Lab 6 - ServiceNow RFC Automation
teaser: Automate this repetitive manual task that doesn't contribute to innovation
  or feature development but is necessary to maintain operations.
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
      <h1>ServiceNow - Request for Change Automation</h1>
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-devsecops/assets/images/dark_mode/CD_Landing_Page_SNow.svg">
      <ul class="features-list">
        <li>Reduced manual effort and toil</li>
        <li>Minimize errors through standardized workflows</li>
        <li>Faster approvals with fewer delays</li>
      </ul>
    </div>
tabs:
- id: kw7qhcj34856
  title: Harness Platform
  type: browser
  hostname: harness
- id: sxuxz1iho840
  title: ServiceNow
  type: browser
  hostname: servicenow
- id: es4txfse87hx
  title: Demo App
  type: website
  url: https://${_SANDBOX_ID}.instruqt.harness-demo.site/
- id: hsnveivxffsg
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: gnxdjvffpx1x
  title: Shell
  type: terminal
  hostname: sandbox
- id: xfn9rjsfl5dd
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
</style><h2 class="cyan">ServiceNow Integration</h2>
<hr class="cyan">
<br><br>

Now let's configure a ServiceNow connector
===
> - Click on **Project Settings** in the left Nav
> - Scroll down to **Project-level resources**
> - Click on **Connectors** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/new_connector.png)
> - And then click `+New Connector`
> - Under **Ticketing Systems** select `ServiceNow` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/connector_servicenow.png)
> - Configure with the details below ↓

> **ServiceNow**
> - **Overview**
>   - Name: <pre>`ServiceNow`</pre>
>   - Click **Continue >**
> - **Details**
>   - ServiceNow URL: <pre>`https://[[ Instruqt-Var key="SN_INSTANCE_ID" hostname="sandbox" ]].service-now.com`</pre>
>   - Username: <pre>`[[ Instruqt-Var key="HARNESS_USER_NAME" hostname="sandbox" ]]`</pre>
>   - Password/API Key:
>     - Click `Create or Select a Secret`
>       - Click `+New Secret Text` \
>            ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/new_secret_text.png)
>       - Secret Name: <pre>`servicenow-pw`</pre>
>       - Secret Value: <pre>`[[ Instruqt-Var key="HARNESS_PWD" hostname="sandbox" ]]`</pre>
>       - Click **Save**
>   - Click **Continue >**
> - **Delegates Setup**
>   - Select or Enter Delegates:
>     - `[[ Instruqt-Var key="HARNESS_USER_NAME" hostname="sandbox" ]]-delegate`
>   - Click **Save and Continue >**
> - **Connection Test**
>   - You should see ***Verification successful***
>   - Click **Finish**

RFC Automation
===
> [!NOTE]
> - The Request for Change (RFC) process is commonly found in large organizations, and is a structured approach to proposing, reviewing, and approving changes.
> - This process often results in repetitive manual tasks that don't contribute to innovation or feature development but are necessary to maintain operations.

## Let's change that by automating our RFC process!
> Head back over to your pipeline
> 1) Hover over the ***Approval*** stage and click the **X** to delete it \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-devsecops/assets/images/pipeline_delete_approval_stage.png)
> 1) Select the ***Frontend - Deployment*** stage
> 1) On the  **Execution** tab
> 1) Before the ***Rollout Deployment*** step
>    1) Select `Add Step`, then `Add Step` again
>    1) Filter the Step Library by clicking on `ServiceNow` in the right nav \
>        ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_step_library_servicenow.png)
>    1) Select `ServiceNow Create` from the Step Library \
>        ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_step_servicenow_create.png)
>    1) Configure with the details below ↓

> **ServiceNow Create**
> - Name: <pre>`ServiceNow - Create Ticket`</pre>
> - ServiceNow Connector: `ServiceNow`
> - Ticket Type: `Change Request`
> - Description: <pre>`Change Detail: Promote version <+variable.username>-<+pipeline.sequenceId> of <+service.name> to production.`</pre>
> - Short Description: <pre>`Begin promotion of <+service.name> to production`</pre>
> - Click **Apply Changes** in the top right


> [!NOTE]
> **Harness Expressions**<br>
> - The Harness platform uses `JEXL` *(Java EXpression Language)* that allow you to reference Harness input, output, and execution values.
> - By eliminating the need to hardcode values you can easily `Templatize` your ***Steps***, ***Stages***, and even entire ***Pipelines***.
> - This enhances developer productivity, reduces onboarding time, and enforces standardization across your enterprise!

<br>

> 1) After the ***Rollout Deployment*** step
>    1) Select `Add Step`, then `Add Step` again
>    1) Filter the Step Library by clicking on `ServiceNow` in the right nav \
>        ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_step_library_servicenow.png)
>    1) Select `ServiceNow Update` from the Step Library \
>        ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_step_servicenow_update.png)
>    1) Configure with the details below ↓

> **ServiceNow Update**
> - Name: <pre>`ServiceNow - Update Ticket`</pre>
> - ServiceNow Connector: `ServiceNow`
> - Ticket Type: `Change Request`
> - Ticket Number: <pre>`<+execution.steps.ServiceNow_Create_Ticket.ticket.ticketNumber>`</pre>
> - Click `+Fields` and select the following fields:
>   1) `Assignment group`
>   1) `Backout plan`
>   1) `Implementation plan`
>   - Scroll to the bottom and click **Add**
> - Assignment group: <pre>`CAB Approval`</pre>
> - Backout plan:<pre>`Harness Continuous Verification and Automatic Rollback.`</pre>
> - Implementation plan:
>  ```
>  Harness Pipeline Deployment Details:
>    Deployed Artifact: <+artifacts.primary.image>
>    Harness Execution: <+pipeline.executionId>
>    Deployment URL: https://app.harness.io/ng/account/<+account.identifier>/all/orgs/<+org.identifier>/default/projects/<+project.identifier>/pipelines/<+pipeline.identifier>/executions/<+pipeline.executionId>/pipeline
>  ```
> - Click **Apply Changes** in the top right

ServiceNow Approval Stage
===
> 1) `After` the ***Frontend - Deployment*** stage click on the `+` icon to add a new stage \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-devsecops/assets/images/pipeline_add_servicenow_approval_stage.png)
> 1) Select `Approval` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_stage_approval.png)
> 1) Configure with the details below ↓

> **About your Stage**
> - Stage Name: <pre>`Approval`</pre>
> - Approval Type: `ServiceNow`
> - Click **Set Up Stage**
>
> **Execution**
> 1) Delete the `Create` and `Update` steps
> 1) Click on the `Approval` step \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-devsecops/assets/images/pipeline_step_servicenow_approval_configure.png)
> 1) Configure with the details below ↓

> **ServiceNow Approval**
> - Name: <pre>`ServiceNow Approval`</pre>
> - ServiceNow Connector: `ServiceNow`
> - Ticket Type: `Change Request`
> - Ticket Number: <pre>`<+pipeline.stages.Frontend_Deployment.spec.execution.steps.ServiceNow_Create_Ticket.ticket.ticketNumber>`</pre>
> - **Approval Criteria**
>   - Click `+Add`
>     - Field: `State`
>     - Operator: `=`
>     - Value: `Implement`
> - Click **Apply Changes** in the top right

> [!NOTE]
> *How does this differ from the `Harness Approval` we setup in a previous lab?*

Execute your Pipeline
===
> Click **Save** in the top right to save your pipeline. \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_save.png)

> Now click **Run** to execute the pipeline \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_run.png)
> Then click **Run Pipeline** \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-devsecops/assets/images/pipeline_run_pipeline.png)

> ## Switch to the [button label="ServiceNow" variant="success"](tab-1) tab to continue
> While we wait for the pipeline to execute, head over to the ServiceNow tab and login using the details provided below.👇
### ServiceNow Credentials:
|  |   |
| ----- | ----- |
| **Username**    |<pre>`[[ Instruqt-Var key="HARNESS_USER_NAME" hostname="sandbox" ]]`</pre>|
| **Password**    |<pre>`[[ Instruqt-Var key="HARNESS_PWD" hostname="sandbox" ]]`</pre>|

> [!NOTE]
> *All credentials for this lab can always be found on the: <br>
>  <img src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/link.svg" alt="Link icon" width="16" height="16" style="display: inline; vertical-align: middle;">[button label="Lab Credentials" variant="success"](tab-5) tab*

CAB Approval
===
> ## Time for the CAB to review and approve our RFC
> - You can switch back to the [button label="Harness Platform" variant="success"](tab-0) tab to check on the progress of your pipeline
> - Once the pipeline reaches `Pending` on the **ServiceNow Approval** step \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/servicenow_pending_approval_step.png)
> - Switch back to the [button label="ServiceNow" variant="success"](tab-1) tab

> [!IMPORTANT]
> If you aren't on the `Change Requests` page, click the Instruqt browser Home button \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/servicenow_home.png)
> If you are already on the `Change Requests` page, you may need to click the Instruqt browser refresh button to see your ticket \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/servicenow_cr_refresh.png)

> - Take a look at the detail we populated the ticket with and when you're ready click `Implement` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/servicenow_implement.png)
> - Head back to the [button label="Harness Platform" variant="success"](tab-0) tab and you will see your pipeline automatically proceed now that our **Approval Criteria** has been met

> [!NOTE]
> *What additional details could we programatically add to this RFC?*

<br>

Conclusion
===

Click the **Check** button to continue.
