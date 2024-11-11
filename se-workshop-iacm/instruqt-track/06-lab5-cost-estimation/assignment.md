---
slug: lab5-cost-estimation
id: zmsivzyqndym
type: challenge
title: Lab 5 - Cost Estimation and State Changes
teaser: Visibility into the Cost of Changes and State Changes
notes:
- type: text
  contents: |
    In this lab you will learn how to utilize Harness IaCM to estimate costs and track state changes in your infrastructure, enabling more informed decision-making.
tabs:
- id: h0gtljogigxs
  title: Harness Platform
  type: browser
  hostname: harness
- id: yiwiyfe9lek4
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
Click the pencil icon next to ```instance_type``` and change the value to ```t3.micro``` and then click the green check mark to save it.
<br><br>

### Let's rerun our provision pipeline to deploy this change
Click on **Pipelines** in the left Nav <br>
Click on your ```IaCM Provision``` pipeline <br>
> Now click **Run** and select your **Workspace** to execute the pipeline. <br>
![pipeline_run.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_run.png)

<br>

Wait for your pipeline to reach the **Approval** step and click **Review** to see the `Planned Changes`. <br>
![iacm_pipeline_review.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_pipeline_review.png) <br>

> From here select one of your **EC2 instances** from the list.
![iacm_planned_changes.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_planned_changes.png)<br>
Scroll down in this list to see the details of the planned change and the ```New Value``` vs. the ```Old Value```
![iacm_instance_type_update.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_instance_type_update.png)<br>

> Now click on the ```Cost Change Estimation``` tab and see what the cost impact of your update will be.<br>
![iacm_cost_change_estimation.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_cost_change_estimation.png)<br>
You can also expand the ```aws_instance``` **Resource Type** to see the detail for your individual **EC2 instances**

> Click **Approve** and the pipeline will proceed with the **apply** step. <br>
![iacm_approve.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_approve.png) <br>

<br><br>

### Now let's explore the `State Comparison` feature
Click on **Workspaces** in the left Nav and click on your workspace <br>

<br>

> ![iacm_state_tab.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_state_tab.png)<br>
From here click on the  **State** tab <br>
You should see two versions here. The Harness IaCM module keeps a version of state for every successful apply to make it easy to track changes over time. <br>
Select the most recent version in the list and then click the dropdown and select the prior version to compare against.
![iacm_state_compare_with.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_state_compare_with.png)
You can now easily see a side-by-side comparison with the differences highlighted.
![iacm_state_compare.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_state_compare.png)

# Congratulations on completing this `Harness IaCM` workshop!
That's all for now. We hope you enjoyed your hands-on experience with the Harness IaCM module. We are always looking to improve so please rate your experience and share any suggestions or issues you may have encountered. Thank you!

===============

Click the **Check** button to continue.
