---
slug: create-an-iacm-pipeline
id: fdfbnnyxqf7y
type: challenge
title: Lab 3 - Create an IaCM Pipeline
teaser: Creating a Pipeline with Approval
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
      <h1>Shared Pipeline for Infrastructure Changes</h1>
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iac_pipeline_graphic.png">
      <ul class="features-list">
        <li>CI/CD for Infrastructure</li>
        <li>Integrated Pipeline</li>
        <li>Scale with Templates</li>
      </ul>
    </div>
tabs:
- id: ddpcsvvuta2o
  title: Harness Platform
  type: browser
  hostname: harness
- id: ycnhyyu4mcmb
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: noxjqopwdhfc
  title: Shell
  type: terminal
  hostname: sandbox
- id: zewvxxxkrhgf
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

Create the Provisioning Pipeline
===

- Click on **Pipelines** in the left Nav

- Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/create_a_pipeline.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> and configure as follows

  > **Create new Pipeline**
  > - Name: `IaCM Provision`
  >
  > - Store: `Inline`
  >
  > - Click **Start**


In the newly created pipeline, perform the following steps:

- Click `+Add Stage`

- Choose **Infrastructure** stage type and configure as follows

  ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_pipeline_stage.png)


  > **About your Stage**
  >
  > - Stage Name: `IaCM`
  >
  > - Click **Set Up Stage**

In the newly created stage, configure as follows:


  > **Infrastructure**
  > 
  > - Infrastructure: **Cloud**
  >
  > - Click **Next >**
  > 
  > **Input**
  > 
  > - **Workspace**: set the type to `Runtime input` by clicking on the pin icon next to the field
  >
  >     ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/pipeline_workspace_runtime_input.png)
  > 
  > - Click **Next >**
  >
  > [!NOTE]*Why do you think we configure the `Workspace` as an input?*
  > <br>
  > 
  > **Operations**
  >
  > - Select **Provision** operation
  >
  >   ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_provision_step.png)
  >
  > - Click **Use Operation**
  >

Based on the Operation selected, the **Execution** tab will be configured with the necessary steps to execute the operation. Now we're going to add an approval step before the `apply` step.

>   - Hover over the pipeline between `plan` and `apply` and click `+` 
>
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_pipeline_add_step.png)
>
>   - Select **Add Step**
>
>   - Select `IACM Approval` from the Step Library and configure as follows:
>
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_approval_step.png)
>
>     **IACM Approval**
>     - Name: `IACM Approval`
>
>     - ✅ Auto approve when the plan does not change
>
>     - Click **Apply Changes** in the top right
>
> [!NOTE]
> Your pipeline should look like this: 
>
>  ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/full_pipeline_iacm_provision.png)
> 
> - Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/save_pipeline.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> in the top right to save the pipeline


Execute the Pipeline
===

- To execute your pipeline, click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/run_pipeline.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> at the top right

- In the **Run Pipeline** dialog, select `demoworkspace` as the workspace

- Click  <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/run_pipeline_2.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> 

- Wait for your pipeline to reach the **IaCM Approval** step
- Click **Review** and take a moment to examine the detailed information 
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_pipeline_review.png)

> [!NOTE]
> *What resources will be added?*


> - Click **Approve Now** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_approve.png)
> - Your pipeline will now proceed with the `apply` step

===============

Click the **Check** button to continue.
