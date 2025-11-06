---
slug: detect-drift
id: 6yofvrgnenhw
type: challenge
title: Lab 4 - Introduce Drift
teaser: Introduce and Detect Drift
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
      <h1>Drift detection</h1>
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iac_drift_detection.png">
      <ul class="features-list">
        <li>Harness IaCM provides automated drift detection and reconciliation, preventing discrepancies between desired and actual state, ensuring git is the single source of truth for infrastructure changes.</li>
      </ul>
    </div>
tabs:
- id: 8i2lzruelguf
  title: Harness Platform
  type: browser
  hostname: harness
- id: ttdko7cyvrxa
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: pdzdsynw3jgq
  title: Shell
  type: terminal
  hostname: sandbox
- id: k9qk1fippqov
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
</style><h2 class="cyan">Lab 5 - Detect Drift</h2>
<hr class="cyan">
<br>

When using Infrastructure as Code, the code is the source of truth and the live infrastructure should match the code definitions/configurations. If someone were to make a change to the live infrastructure directly, it's important to be able to identify and remediate that change to bring it back in sync with the code.

Introduce Drift
===

Now it's time to introduce some drift into our environment.


## Switch to the [button label=">_Shell" variant="success"](tab-2) tab to continue

### List out our instances
```bash,run
aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,Tags[?Key=='name'].Value | [0]]" \
  | jq
```

### Target one of them for some manual changes
```bash
TARGETED_INSTANCE="<replaceWithInstanceId>"
```

### Stop one of the EC2 instances we just provisioned
```bash,run
aws ec2 stop-instances \
  --instance-ids $TARGETED_INSTANCE \
  | jq
```
### Wait for the EC2 instance to be in `stopped` state
```bash,run
aws ec2 wait instance-stopped --instance-ids $TARGETED_INSTANCE
```

### Change that EC2 instance to `t3.micro`
```bash,run
aws ec2 modify-instance-attribute \
  --instance-id $TARGETED_INSTANCE \
  --instance-type "{\"Value\": \"t3.micro\"}"
```

### Run the `describe-instances` command again to confirm the change
```bash,run
aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,Tags[?Key=='name'].Value | [0]]" \
  | jq
```

<!--Create a Pipeline to Detect Drift
=== -->

Now let's create an IaCM Pipeline to detect drift


## Switch to the [button label="Harness Platform" variant="success"](tab-0) tab to continue

- Click on **Pipelines** in the left Nav

- Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/create_a_pipeline.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> and configure as follows

  > **Create new Pipeline**
  > - Name: `IaCM Drift`
  >
  > - Store: `Inline`
  >
  > - Click **Start**


In the newly created pipeline, perform the following steps:

- Click `+Add Stage`

- Choose **Infrastructure** stage type and configure as follows

  > ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_pipeline_stage.png)
  > **About your Stage**<br><br>
  > - Stage Name: `IaCM`
  > - Click **Set Up Stage**

In the newly created stage, configure as follows:

  > **Infrastructure**<br><br>
  > - Infrastructure: **Cloud**
  > - Click **Next >**<br>
  >
  > **Input**<br><br>
  > - **Workspace**: set the type to `Runtime input` by clicking on the pin icon next to the field. <br><br>*Note that you may get a tooltip that explains the different input types. If so, please close the tooltip in order to access the pin icon.*
  >
  >     ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iacm/workspace_runtime_input.png)
  > - Click **Next >**
  >
  > **Operations**<br><br>
  > - Select **Detect Drift** operation
  >    ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_drift_step.png)
  > - Click **Use Operation**
  >


> [!NOTE]
> Your pipeline should look like this: \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/full_pipeline_iacm_drift.png)

Execute the Pipeline
===

- To execute your pipeline, click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/run_pipeline.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> at the top right

- In the **Run Pipeline** dialog, select `demoworkspace` as the workspace

- Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/run_pipeline_2.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;">

> [!NOTE]
>  - *What do you expect to happen?*
>  - *What drift should be detected?*

- Wait for the pipeline to complete

- Click on the <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iacm/resources_tab.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> tab


- Click on <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iacm/drift_changes_tab.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;">

- Select the drifted **EC2 instance** from the list

	![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iacm/changed_resource.png)

- Scroll down in this list to see the details of the drift detected and the `Actual Value` vs. the `Expected Value`
![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_drift_details.png)

> [!NOTE]
> - *Was this what you expected to see?*

===============

Click the **Check** button to continue.
