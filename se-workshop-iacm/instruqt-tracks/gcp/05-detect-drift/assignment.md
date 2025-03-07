---
slug: detect-drift
id: 7uyki5j2rv22
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
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/iac_drift_detection.png">
      <ul class="features-list">
        <li>Harness IaCM provides automated drift detection and reconciliation, preventing discrepancies between desired and actual state, ensuring git is the single source of truth for infrastructure changes.</li>
      </ul>
    </div>
tabs:
- id: f5gdaz4p23wn
  title: Harness Platform
  type: browser
  hostname: harness
- id: w6zsyxpuzyrv
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: g280oelfxrpm
  title: Shell
  type: terminal
  hostname: sandbox
- id: okytaesgpvox
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
</style><h2 class="cyan">Introduce Drift</h2>
<hr class="cyan">
<br>

> ## Switch to the [button label=">_Shell" variant="success"](tab-2) tab to continue

## Now it's time to introduce some drift

### Activate our credentials
```bash,run
gcloud auth activate-service-account --key-file=/opt/workshop/sa-key.json
```

### List out our instances
```bash,run
gcloud compute instances list \
  --format="table(name, zone, status, machineType)"
```

### Target one of them for some manual changes
```bash
TARGETED_INSTANCE="<replaceWithInstanceName>"
```

### Stop one of the GCE instances we just provisioned
```bash,run
gcloud compute instances stop $TARGETED_INSTANCE \
  --zone="[[ Instruqt-Var key="HARNESS_GCP_ZONE" hostname="sandbox" ]]"
```

### Change that GCE instance to `e2-small`
```bash,run
gcloud compute instances set-machine-type $TARGETED_INSTANCE \
  --machine-type=e2-small \
  --zone="[[ Instruqt-Var key="HARNESS_GCP_ZONE" hostname="sandbox" ]]"

```

### Run the `instances describe` command again to confirm the change
```bash,run
gcloud compute instances list \
  --format="table(name, zone, status, machineType)"
```

> ## Switch to the [button label="Harness Platform" variant="success"](tab-0) tab to continue

## Now let's create an IaCM Pipeline to detect drift
Click on **Pipelines** in the left Nav <br>
And then click `+Create Pipeline` <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_create.png)

> **Create new Pipeline**
> - Name: <pre>`IaCM Drift`</pre>
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

<br>

> - Select **Detect Drift** operation \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_drift_step.png)
> - Click **Use Operation**

<br>

> [!NOTE]
> Your pipeline should look like this: \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/full_pipeline_iacm_drift.png)

<br>

### Execute your new IaCM Pipeline
> - Click **Save** in the top right to save your new pipeline \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_save.png)
> - Now click **Run** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_run.png)
> - Then select your `demoworkspace` **Workspace** to execute the pipeline
> - Click **Run Pipeline**

> [!NOTE]
> - *What do you expect to happen?*
> - *What drift should be detected?*

<br>

> **Now that the piplne execution has completed**
> - Click on the `Resources` tab \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_drift_resources.png)
> - Click on `Drift Changes` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_drift_changes_gcp.png)
> - Select the drifted **GCE instance** from the list
> - Scroll down in this list to see the details of the drift detected and the `Actual Value` vs. the `Expected Value` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_drift_details_gcp.png)

> [!NOTE]
> - *Was this what you expected to see?*

===============

Click the **Check** button to continue.
