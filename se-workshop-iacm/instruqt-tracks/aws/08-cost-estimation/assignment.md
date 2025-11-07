---
slug: cost-estimation
id: w7nzy5oea196
type: challenge
title: Lab 7 - Cost Estimation and State Changes
teaser: Visibility into the Cost of Changes and State Changes
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
      <h1>Cost estimation and State management</h1>
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iac_state_management.png">
      <ul class="features-list">
        <li>Harness IaCM helps users proactively identify cost impact associated with resource changes, which prevents unplanned and exorbitant cloud bills.</li>
        <li>Harness provides an out-of-the-box hosted backend, eliminating the need to host state and manage locking mechanism and access control.</li>
      </ul>
    </div>
tabs:
- id: 2dfqbifjexen
  title: Harness Platform
  type: browser
  hostname: harness
- id: uk162ur6rzep
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: y8h0rccvmd8q
  title: Shell
  type: terminal
  hostname: sandbox
- id: y3f9iouyuuly
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
</style><h2 class="cyan">Cost Estimation and State Changes</h2>
<hr class="cyan">
<br>

Cost Estimation
===

## Now let's explore Cost Estimation
Head back over to your workspace. 
- Click **Workspaces** in the left Nav
- Click into **demo-workspace**
- Click on the **Connectors and Variables** tab
- Under the **Terraform Variables** section, change the value for the **instance_type** variable to `t3.micro`
- Click  <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iacm/save_changes.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;">

### Let's rerun our provisioning pipeline to deploy this change
- Click on **Pipelines** in the left Nav
- Click on the **IaCM Provision** pipeline
- To execute your pipeline, click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/run_pipeline.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> at the top right
- In the **Run Pipeline** dialog, select `demoworkspace` as the workspace
- Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/run_pipeline_2.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;">
<br><br>
- Wait for your pipeline to reach the **IaCM Approval** step
- Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iacm/approval_review.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> and take a moment to examine the detailed information

>  **Monthly Cost Change** details the cost impact of this potential change<br><br>
>  You can expand the **aws_instance** Resource Type to see the detail for the individual **EC2 instances**
>  	![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_cost_change_estimation.png)
>  	Scroll down from here and select one of your **EC2 instances** from the list
>  	 ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_planned_changes.png)
>  	 Scroll down in this list to see the details of the planned change and the **New Value** versus the **Old Value**

- Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iacm/approve.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;">
- Your pipeline will now proceed with the **apply** step and update the resources in your AWS account


State Comparison
===
## Now let's explore the **State Comparison** feature
- Click **Workspaces** in the left Nav
- Click into **demo-workspace**
- Click on the **State** tab
- Select the most recent version in the list (there should be 2 versions listed)
- In the **Compare with** dropdown, select the prior version 

You can now easily see a side-by-side comparison with the differences highlighted
![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_state_compare.png)

> [!NOTE]
> The Harness IaCM module keeps a version of state for every successful apply to make it easy to track changes over time

===============

Click the **Check** button to continue.
