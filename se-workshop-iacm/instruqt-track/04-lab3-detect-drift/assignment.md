---
slug: lab3-detect-drift
id: caynop70jpgy
type: challenge
title: Lab 3 - Introduce Drift
teaser: Introduce and Detect Drift
notes:
- type: text
  contents: |
    This lab focuses on detecting configuration drifts in your infrastructure. Participants will learn how to set up drift detection, interpret its results, and understand the impact of drift on infrastructure management.
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
  path: /aws_credentials.html
  port: 8000
difficulty: basic
timelimit: 1600
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Introduce Drift</h2>
<hr class="cyan">
<br>

> # Switch to the ```>_Shell``` tab to continue

## Now it's time to introduce some drift

### List out our instances
```
aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,Tags[?Key=='name'].Value | [0]]" \
  | jq
```

### Target one of them for some manual changes
```
TARGETED_INSTANCE="<replaceWithInstanceId>"
```

### Stop one of the EC2 instances we just provisioned
```
aws ec2 stop-instances \
  --instance-ids $TARGETED_INSTANCE \
  | jq
```

### Change that EC2 instance to ```t3.micro```
```
aws ec2 modify-instance-attribute \
  --instance-id $TARGETED_INSTANCE \
  --instance-type "{\"Value\": \"t3.micro\"}"
```

### Run the ```describe-instances``` command again to confirm the change
```
aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,Tags[?Key=='name'].Value | [0]]" \
  | jq
```

> # Switch back to the ```Harness Platform``` to continue

## Now let's create an IaCM Pipeline to detect drift
Click on **Pipelines** in the left Nav <br>
And then click ```+Create Pipeline``` <br>
![Create_Pipeline.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/Create_Pipeline.png)

> **Create new Pipeline**
> - Name: ```IaCM Drift``` <br>
> - Store: ```Inline``` <br>

<br><br>
Click ```+Add Stage``` <br>
> Choose **Infrastructure** stage type <br>
![iacm_pipeline_stage.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_pipeline_stage.png)<br>
Give it a name: ```IaCM```

<br><br>
> ![pipeline_infrastructure_tab.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_infrastructure_tab.png)<br>
Keep the defaults on the  **Infrastructure** tab and click **Next >**

<br><br>
> ![pipeline_workspace_tab.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_workspace_tab.png)<br>
On the **Workspace** tab set the type to ```Runtime input``` and click **Next >** <br>
![pipeline_workspace_runtime_input.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_workspace_runtime_input.png)

<br><br>
Select **Detect Drift** operation and click **Use Operation** <br>
![iacm_drift_step.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_drift_step.png)

<br><br>
Your pipeline should look like this: <br>
![IaCM_Drift.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/IaCM_Drift.png)

<br><br>

### Execute your new IaCM Pipeline
> Click **Save** in the top right to save your new pipeline. <br>
![pipeline_save.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_save.png) <br>

> Now click **Run** and select your **Workspace** to execute the pipeline. <br>
![pipeline_run.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_run.png)

<br><br><br>
`What do you expect to happen?`
<br><br><br>

> Now that the piplne execution has completed, click on the ```Resources``` tab and see what drift has been detected.<br>
![iacm_drift_resources.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_drift_resources.png)<br>
From this tab click on ```Drift Changes``` and then select one of your **EC2 instances** from the list.
![iacm_drift_changes.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_drift_changes.png)<br>
Scroll down in this list to see the details of the drift detected and the ```Actual Value``` vs. the ```Expected Value```
![iacm_drift_details.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_drift_details.png)<br>

===============

Click the **Check** button to continue.
