---
slug: lab7-governance
id: wzcblxyp7wdy
type: challenge
title: Lab 7 - Governance and Policy as Code
teaser: Explore how to enforce governance via OPA policies within Harness, defining
  and applying policy rules to ensure compliance and best practices across your projects.
notes:
- type: text
  contents: |
    In Lab 5 we saw how a user is impacted by policies in place, now is the time to create our own policy
    - Create a policy that evaluates when editing pipelines
    - Test policy enforcement
tabs:
- id: sk5nflejqtgb
  title: Harness Platform
  type: browser
  hostname: harness
- id: nqmcp2aqyp7z
  title: Demo App
  type: website
  url: https://sandbox-8080-${_SANDBOX_ID}.env.play.instruqt.com/
- id: 8qccrvt58xqx
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: 1uawafxobeyc
  title: Shell
  type: terminal
  hostname: sandbox
- id: x4wb9joq6okw
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

# Now let's configure a policy
- Click on **Project Settings** in the left Nav
- Then scroll down to **Security and Governance** and click **Policies**
- This is the Overview screen. In the top right of this screen click **Policies** \
    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/opa_new_policy.png)
- And then click ```+New Policy``` <br>

## Create new Policy to require approval for Production releases
> **Policy Name**
> - Name: <pre>`Production Approval`</pre>
> - Store: `Inline`

> [!NOTE]
> ***OPA Rego Policy*** <br>
> This policy mandates an ***Approval*** stage prior to production deployments. <br>
> In this lab we are using the `Harness Approval` but this could also use our native integrations with `ServiceNow` and `Jira`.

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
> Click **Save** in the top right to save your new policy <br>

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
>   - Policy to Evaluate: `Production Approval`
>   - Policy Action: `Error and exit`
>   - Click **Apply**
> - Click **Finish** to save your **Policy Set**


> [!WARNING]
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/opa_policy_toggle.png)
>  Be sure to click the `toggle` under **ENFORCED** to enable your **Policy Set** !!

## Let's test it out
> Head back over to your pipeline.
> 1) Select the ***Frontend - Deployment*** stage \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_environment.png)
> 2) Click on the  **Environment** tab
>   - Specify Environment: `prod`
>   - Specify Infrastructure: `K8s Prod`

> Click **Save** in the top right to save your pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_save.png)

## Pipeline can not be saved due to the policy evaluation failures
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_pipeline_missing_approval.png)

> [!IMPORTANT]
> Oops. That's not allowed. Let's add an approval stage so we can get back on track.

> 1) `Before` the ***Frontend - Deployment*** stage click on the `+` icon to add a new stage \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_pipeline_add_approval_stage.png)
> 2) Select `Approval` and configure with the details below ↓ \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_stage_approval.png)
>
> **About your Stage**
> - Stage Name: <pre>`Approval`</pre>
> - Approval Type: `Harness Approval`
> - Click **Setup Stage**
>
> 3) Click on the `Approval` step and configure with the details below ↓
>
> **Manual Approval**
> - Name: <pre>`Harness Approval`</pre>
> - **Approvers**
>   - User Groups: `Production Approvers` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_approval_group.png)
> - After completing configuration click **Apply Changes** from the top right of the configuration popup

> Click **Save** in the top right to save your pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_save.png)

# Success!

### Execute your Pipeline
> Now click **Run** to execute the pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_run.png)

<br>

> [!NOTE]
> That is `Policy as Code` in action! Isn't it beautiful? <br>
> Harness has wrapped the ***entire platform*** with `OPA` so this is just the tip of the iceberg! <br>

# Congratulations on completing this **Harness workshop**! 🏆
### That's all for now. We hope you enjoyed your hands-on experience with the Harness platform. <br> 📈 We are always looking to improve so please rate your experience and share any suggestions or issues you may have encountered. Thank you!

===============

Click the **Check** button to continue.
