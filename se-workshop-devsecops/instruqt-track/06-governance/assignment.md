---
slug: governance
id: gkzngarfph4u
type: challenge
title: Lab 5 - Governance via Policy as Code
teaser: Explore how to enforce governance via OPA policies within Harness, defining
  and applying policy rules to ensure compliance and best practices across your projects.
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

      .sub-container {
        display: flex;
        flex-direction: row;
        align-items: flex-start;
      }

      .harness-image {
        max-width: 90%;
        max-height: 55%;
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

      .features-list .sub-list {
        list-style-type: disc;
        margin-left: 20px;
        font-weight: normal;
        font-size: 20px;
        font-style: italic;
      }

      @media (max-width: 768px) {
        .features-list li {
          font-size: 1.25rem;
        }

        .features-list .sub-list {
          font-size: 1.25rem;
        }
      }

      @media (max-width: 480px) {
        .features-list li {
          font-size: 1rem;
        }

        .features-list .sub-list {
          font-size: 1rem;
        }
    </style>

    <div class="container">
      <h1>Guardrail your deployments</h1>
      <div class="sub-container">
        <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/cd_opa_guardrails.avif">
        <ul class="features-list">
          <li>Flexible policies using Open Policy Agent</li>
          <li>Give developers permission to edit pipelines while central teams dictate rules like:
            <ul class="sub-list">
              <li>All production deployments must have an approval step</li>
              <li>All deployments must use an approved container registry</li>
            </ul>
          </li>
          <li>With OPA, teams can be empowered while scalable guardrails ensure compliance</li>
        </ul>
      </div>
    </div>
tabs:
- id: phoolyx7ds2h
  title: Harness Platform
  type: browser
  hostname: harness
- id: fabyuz4axeuf
  title: Demo App
  type: website
  url: https://${_SANDBOX_ID}.instruqt.harness-demo.site/
- id: txq9436jyt46
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: rzzyrcxloqr2
  title: Shell
  type: terminal
  hostname: sandbox
- id: 82h58cua3w2d
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
</style><h2 class="cyan">Guardrails through OPA Policy</h2>
<hr class="cyan">
<br><br>

## Now let's configure a policy
> - Click on **Project Settings** in the left Nav
> - Scroll down to **Security and Governance**
> - Click on **Policies**
> - This is the Overview screen
>   - In the top right of this screen click **Policies** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/opa_new_policy.png)
>   - Then click `+New Policy` and configure with the details below ↓

> [!IMPORTANT]
> ***OPA Rego Policy*** <br>
> This policy mandates an ***Approval*** stage prior to production deployments. <br>
> In this lab we are using the `Harness Approval` but this could also use our native integrations with `ServiceNow` and `Jira`.


> **Policy Name**
> - Name: <pre>`Production Approval`</pre>
> - Store: `Inline`
> - Click **Apply**
> - Paste in the `OPA Rego Policy` below ↓
```
package pipeline

required_steps = ["HarnessApproval"]

deny[msg] {
    some prod_index
    input.pipeline.stages[prod_index].stage.spec.infrastructure.environment.type == "Production"
    not approval_before_prod(prod_index)
    msg := sprintf("Deployment to higher environments require an approval stage. '%s' does not have an Approval stage", [input.pipeline.stages[prod_index].stage.name])
}

deny[msg] {
    some prod_index
    input.pipeline.stages[prod_index].stage.spec.infrastructure.environment.type == "Production"
    stage = input.pipeline.stages[_].stage
    stage.type == "Approval"
    existing_steps := [s | s = stage.spec.execution.steps[_].step.type]
    required_step := required_steps[_]
    not contains(existing_steps, required_step)
    msg := sprintf("Approval stage '%s' is missing required step '%s'", [stage.name, required_step])
}

approval_before_prod(prod_index) {
    some approval_index
    approval_index < prod_index
    input.pipeline.stages[approval_index].stage.type == "Approval"
}

contains(arr, elem) {
    arr[_] = elem
}
```
> - Click **Save** in the top right to save your new policy

> [!NOTE]
> *What does this policy accomplish?*

## Create new Policy Set
> 1) In the top right of this screen click **Policy Sets** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/opa_new_policy_set.png)
> 2) And then click `+New Policy Set` <br>
>
> **Policy Set**
> - **Overview**
>   - Name: <pre>`Approval Required for Production Deployments`</pre>
>   - Entity Type: `Pipeline`
>   - Evaluation: `On Save`
>   - Click **Continue**
> - **Policy evaluation criteria**
>   - Click : `+ Add Policy`
>   - **Select Policy**
>     - Policy to Evaluate: `Production Approval`
>     - Policy Action: `Error and exit`
>     - Click `Apply`
>   - Click `Finish` to save your **Policy Set**


> [!WARNING]
> - Be sure to click the toggle under `ENFORCED` to enable your **Policy Set** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/opa_policy_toggle.png)

> [!NOTE]
> *How is this policy set enforcing our policy?*

## Let's test it out
> Head back over to your pipeline.
> 1) Select the ***Frontend - Deployment*** stage \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_environment.png)
> 2) Click on the  **Environment** tab
>   - Specify Environment: `Prod`
>   - Specify Infrastructure: `K8s Prod`

> Click **Save** in the top right to save your pipeline. \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_save.png)

> [!IMPORTANT]
> Oops. That's not allowed. \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_pipeline_missing_approval.png)
> Click the **X** in the upper right of this pop-up and let's add an approval stage so we can get back on track.

> 1) `Before` the ***Frontend - Deployment*** stage click on the `+` icon to add a new stage \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_pipeline_add_approval_stage.png)
> 1) Select `Approval` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_stage_approval.png)
> 1) Configure with the details below ↓

> **About your Stage**
> - Stage Name: <pre>`Approval`</pre>
> - Approval Type: `Harness Approval`
> 1) Click **Set Up Stage**
> 1) Click on the `Approval` step and configure with the details below ↓

> **Manual Approval**
> - Name: <pre>`Harness Approval`</pre>
> - **Approvers**
>   1) User Groups: Click `Select User Group(s)`
>      1) Click on `Project`
>      1) Select: `Production Approvers` \
>         ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_approval_group.png)
>      1) Click **Apply Selected**
> - Click **Apply Changes** in the top right

> Click **Save** in the top right to save your pipeline \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_save.png)

# Success!

### Execute your Pipeline
> Now click **Run** to execute the pipeline \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_run.png)

<br>

> [!NOTE]
> That is `Policy as Code` in action! Isn't it beautiful? <br>
> Harness has wrapped the ***entire platform*** with `OPA` so this is just the tip of the iceberg! <br>

===============

Click the **Check** button to continue.
