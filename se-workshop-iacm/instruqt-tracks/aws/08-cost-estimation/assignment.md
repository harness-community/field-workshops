---
slug: cost-estimation
id: bpudglwdk7mc
type: challenge
title: Lab 6 - Cost Estimation and State Changes
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
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/iac_state_management.png">
      <ul class="features-list">
        <li>Harness IaCM helps users proactively identify cost impact associated with resource changes, which prevents unplanned and exorbitant cloud bills.</li>
        <li>Harness provides an out-of-the-box hosted backend, eliminating the need to host state and manage locking mechanism and access control.</li>
      </ul>
    </div>
tabs:
- id: i5yyslrra1gt
  title: Harness Platform
  type: browser
  hostname: harness
- id: bxoazd66oco3
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: zvzumqgcakty
  title: Shell
  type: terminal
  hostname: sandbox
- id: cx3vmkkx02yi
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

## Now let's explore `Cost Estimation`
> **Configure Workspace**
> - Click the **pencil** icon next to `instance_type`
> - Change the value to <pre>`t3.micro`</pre>
> - Click ✅ to save this variable

### Let's rerun our provision pipeline to deploy this change
> - Click on **Pipelines** in the left Nav
> - Click on your `IaCM Provision` pipeline
> - Now click **Run** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_run.png)
> - Then select your `demoworkspace` **Workspace** to execute the pipeline
> - Click **Run Pipeline**

<br>

> - Wait for your pipeline to reach the **Approval** step
> - Click **Review** and let's examine the detailed information \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-iacm/assets/images/iacm_pipeline_review.png)
> - First the `Monthly Cost Change` details what the cost impact of your update will be \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-iacm/assets/images/iacm_cost_change_estimation.png)
> - You can also expand the `aws_instance` **Resource Type** to see the detail for your individual **EC2 instances**
> - Scroll down from here and select one of your **EC2 instances** from the list \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-iacm/assets/images/iacm_planned_changes.png)
> - Scroll down in this list to see the details of the planned change and the `New Value` vs. the `Old Value` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-iacm/assets/images/iacm_instance_type_update.png)

> Click **Approve** and the pipeline will proceed with the **apply** step \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-iacm/assets/images/iacm_approve.png)

<br>

## Now let's explore the `State Comparison` feature
> - Click on **Workspaces** in the left Nav
> - Click on your workspace
> - From here click on the  **State** tab \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-iacm/assets/images/iacm_state_tab.png)
>   - You should see two versions here
>   - Select the most recent version in the list
>   - Click the dropdown and select the prior version to compare against \
>       ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-iacm/assets/images/iacm_state_compare_with.png)
>   - You can now easily see a side-by-side comparison with the differences highlighted \
>       ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-iacm/assets/images/iacm_state_compare.png)

> [!NOTE]
> The Harness IaCM module keeps a version of state for every successful apply to make it easy to track changes over time

===============

Click the **Check** button to continue.
