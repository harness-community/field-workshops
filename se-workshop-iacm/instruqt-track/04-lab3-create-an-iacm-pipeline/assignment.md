---
slug: lab3-create-an-iacm-pipeline
id: unafzdkisjiw
type: challenge
title: Lab 3 - Create an IaCM Pipeline
teaser: Creating a Pipeline with Approval
notes:
- type: text
  contents: |
    Learn how to create a pipeline in Harness IaCM. This lab will cover the basics of pipeline configuration, including how to trigger deployments and manage infrastructure changes effectively.
tabs:
- id: eeddtl9wsi8s
  title: Harness Platform
  type: browser
  hostname: harness
- id: acvnczalqgr9
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: u6bks0h2mxuy
  title: Shell
  type: terminal
  hostname: sandbox
- id: t6hzf8anqvx5
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
</style><h2 class="cyan">Create Pipeline</h2>
<hr class="cyan">
<br>

## Now it's time to create an IaCM Pipeline
> - Click on **Pipelines** in the left Nav
> - Click `+Create Pipeline` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_create.png)

> **Create new Pipeline**
> - Name: <pre>`IaCM Provision`</pre>
> - Store: `Inline`
> - Click **Start**

<br>

> - Click `+Add Stage` <br>
> - Choose **Infrastructure** stage type \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_pipeline_stage.png)
> - Give it a name: <pre>`IaCM`</pre>
> - Click **Set Up Stage**

<br>

> - On the  **Infrastructure** tab \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_infrastructure.png)
> - Keep the defaults (**Cloud**)
> - Click **Next >**

<br>

> - On the **Workspace** tab \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_workspace.png)
> - Set the type to `Runtime input` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_workspace_runtime_input.png)
> - Click **Next >**

> [!NOTE]
> *Why do you think we configure the `Workspace` as an input?*

<br>

> - Select **Provision** operation \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_provision_step.png)
> - Click **Use Operation**

<br>

> - On the **Execution** tab \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_execution.png)
> - Hover over the pipeline between `plan` and `apply` and click `+` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_pipeline_add_step.png)
> - Select **Add Step** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_approval_step.png)
> - Select `IACM Approval` from the Step Library and configure with the details below ↓


> **IACM Approval**
> - Name: <pre>`IACM Approval`</pre>
> - ✅ Auto approve when the plan does not change
> - After completing configuration select **Apply Changes** from the top right of the configuration popup

<br>

> [!NOTE]
> Your pipeline should look like this: \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/full_pipeline_iacm_provision.png)

### Execute your new IaCM Pipeline
> - Click **Save** in the top right to save your new pipeline \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_save.png)
> - Now click **Run** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_run.png)
> - Then select your `demoworkspace` **Workspace** to execute the pipeline
> - Click **Run Pipeline**

<br>

> - Wait for your pipeline to reach the **Approval** step
> - Click **Review** and take a moment to examine the detailed information \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_pipeline_review.png)

> [!NOTE]
> *What resources will be added?*


> - Click **Approve Now** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_approve.png)
> - Your pipeline will now proceed with the `apply` step

===============

Click the **Check** button to continue.
