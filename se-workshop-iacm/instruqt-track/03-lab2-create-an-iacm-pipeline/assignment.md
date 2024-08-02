---
slug: lab2-create-an-iacm-pipeline
id: o5ot7fdsgumt
type: challenge
title: Lab 2 - Create an IaCM Pipeline
teaser: Creating a Pipeline with Approval
notes:
- type: text
  contents: |
    Learn how to create a pipeline in Harness IaCM. This lab will cover the basics of pipeline configuration, including how to trigger deployments and manage infrastructure changes effectively.
tabs:
- title: Harness Platform
  type: browser
  hostname: harness
- title: Shell
  type: terminal
  hostname: sandbox
- title: Lab Credentials
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
</style><h2 class="cyan">Create Pipeline</h2>
<hr class="cyan">
<br>

## Now it's time to create an IaCM Pipeline
Click on **Pipelines** in the left Nav <br>
And then click ```+Create Pipeline``` <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/Create_Pipeline.png)

> **Create new Pipeline**
> - Name: ```IaCM Provision```
> - Store: ```Inline```

<br><br>
Click ```+Add Stage``` <br>
> Choose **Infrastructure** stage type <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_pipeline_stage.png)<br>
Give it a name: ```IaCM```

<br><br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_infrastructure.png)<br>
Keep the defaults on the  **Infrastructure** tab and click **Next >**

<br><br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_workspace.png)<br>
On the **Workspace** tab set the type to ```Runtime input``` and click **Next >** <br>
![pipeline_workspace_runtime_input.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_workspace_runtime_input.png)

<br><br>
Select **Provision** operation and click **Use Operation** <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_provision_step.png)

<br><br>
In the pipeline click ```+``` between plan and apply and **Add Step** <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/Add_Step.png)

<br><br>
Select **IACM Approval** <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_approval_step.png)

<br><br>

Your pipeline should look like this: <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/IaCM_Provision.png)<br>

### Execute your new IaCM Pipeline
> Click **Save** in the top right to save your new pipeline. <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_save.png) <br>

> Now click **Run** and select your **Workspace** to execute the pipeline. <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_run.png)

<br>

Wait for your pipeline to reach the **Approval** step and click **Review** to see the `Planned Changes`. <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_pipeline_review.png) <br>

> Click **Approve** and the pipeline will proceed with the **apply** step. <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_approve.png) <br>

===============

Click the **Check** button to continue.
