---
slug: detect-drift
id: ulwklloxiiuq
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
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/iac_drift_detection.png">
      <ul class="features-list">
        <li>Harness IaCM provides automated drift detection and reconciliation, preventing discrepancies between desired and actual state, ensuring git is the single source of truth for infrastructure changes.</li>
      </ul>
    </div>
tabs:
- id: bhvnsyweptc4
  title: Harness Platform
  type: browser
  hostname: harness
- id: y42hx7wrywx2
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: 5hphfptubgjh
  title: Shell
  type: terminal
  hostname: sandbox
- id: sc4ekvyermfq
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
az login --service-principal \
  -u "$ARM_CLIENT_ID" \
  -p "$ARM_CLIENT_SECRET" \
  --tenant "$ARM_TENANT_ID"
```

### List out our instances
```bash,run
az vm list \
  --resource-group main-rg \
  --query "[].{Name:name, State:powerState, Size:hardwareProfile.vmSize, TagName:tags.name}" \
  --output json | jq
```

### Target one of them for some manual changes
```bash
TARGETED_INSTANCE="<replaceWithInstanceName>"
```

### Stop one of the VM instances we just provisioned
```bash,run
az vm stop \
  --resource-group main-rg \
  --name $TARGETED_INSTANCE \
  --output json | jq
```

### Change that VM instance to `Standard_B2s`
```bash,run
az vm resize \
  --resource-group main-rg \
  --name $TARGETED_INSTANCE \
  --size Standard_B2s \
  --output json | jq
```

### Run the `vm list` command again to confirm the change
```bash,run
az vm list \
  --resource-group main-rg \
  --query "[].{Name:name, State:powerState, Size:hardwareProfile.vmSize, TagName:tags.name}" \
  --output json | jq
```

> ## Switch to the [button label="Harness Platform" variant="success"](tab-0) tab to continue

## Now let's create an IaCM Pipeline to detect drift
Click on **Pipelines** in the left Nav <br>
And then click `+Create Pipeline` <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_create.png)

> **Create new Pipeline**
> - Name: <pre>`IaCM Drift`</pre>
> - Store: `Inline`
> - Click **Start**

> - Click `+Add Stage` <br>
> - Choose **Infrastructure** stage type \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-iacm/assets/images/iacm_pipeline_stage.png)
> - Give it a name: <pre>`IaCM`</pre>
> - Click **Set Up Stage**

> - On the  **Infrastructure** tab \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_tab_infrastructure.png)
> - Keep the defaults (**Cloud**)
> - Click **Next >**

> - On the **Workspace** tab \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_tab_workspace.png)
> - Set the type to `Runtime input` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_workspace_runtime_input.png)
> - Click **Next >**

> - Select **Detect Drift** operation \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-iacm/assets/images/iacm_drift_step.png)
> - Click **Use Operation**

> [!NOTE]
> Your pipeline should look like this: \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-iacm/assets/images/full_pipeline_iacm_drift.png)

### Execute your new IaCM Pipeline
> - Click **Save** in the top right to save your new pipeline \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_save.png)
> - Now click **Run** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_run.png)
> - Then select your `demoworkspace` **Workspace** to execute the pipeline
> - Click **Run Pipeline**

> [!NOTE]
> - *What do you expect to happen?*
> - *What drift should be detected?*

> **Now that the piplne execution has completed**
> - Click on the `Resources` tab \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-iacm/assets/images/iacm_drift_resources.png)
> - Click on `Drift Changes` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-iacm/assets/images/iacm_drift_changes_azure.png)
> - Select the drifted **Azure VM instance** from the list
> - Scroll down in this list to see the details of the drift detected and the `Actual Value` vs. the `Expected Value` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-iacm/assets/images/iacm_drift_details_azure.png)

> [!NOTE]
> - *Was this what you expected to see?*

===============

Click the **Check** button to continue.
