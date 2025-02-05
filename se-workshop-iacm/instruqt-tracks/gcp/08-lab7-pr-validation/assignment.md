---
slug: lab7-pr-validation
id: obxlxakxlupr
type: challenge
title: Lab 7 - PR Triggers and Validation
teaser: Harness IaCM supports reviewing infrastructure changes via pull request automation
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
      <h1>PR automation</h1>
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/iac_pr_automation.png">
      <ul class="features-list">
        <li>By implementing PR automation, developers significantly reduce the likelihood of errors when making resource changes. This capability brings the visibility of planned changes into the PR process.</li>
      </ul>
    </div>
tabs:
- id: 7medyzwrmcyc
  title: Harness Platform
  type: browser
  hostname: harness
- id: jftybyy7bl1p
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: cfeu9wu3uvho
  title: Shell
  type: terminal
  hostname: sandbox
- id: yvvrm62hnvy1
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
</style><h2 class="cyan">PR Triggers and Validation</h2>
<hr class="cyan">
<br>

## Now let's create a PR Pipeline
> - Click on **Pipelines** in the left Nav
> - Click `+Create Pipeline` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_create.png)

> **Create new Pipeline**
> - Name: <pre>`IaCM Validation`</pre>
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

> - Select **Pull Request** operation \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_pr_step.png)
> - Click **Use Operation**
> - Click **Save** in the top right to save your new pipeline \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_save.png)

<br>

## Create a Pipeline Trigger
> - Click on **Triggers** in the top right of the pipeline screen \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_pipeline_triggers.png)
> - Click `+New Trigger` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_pipeline_new_trigger.png)

> **New Triggers**
> - Webhook: `Harness` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_pipeline_new_trigger_harness.png)
> - **1) Configuration**
>   - **Trigger Configuration: On New Webhook**
>     - Name: <pre>`PR`</pre>
>   - **Listen on New Webhook**
>     - Repository: `iacm-repo`
>     - Event: `Pull Request`
>     - Actions: `Create`
>   - Click **Continue >**
> - **2) Conditions**
>   - **Conditions**
>     - Attribute: `Changed Files`
>       - Operator: `Starts With`
>       - Matches Value: <pre>`gcp/v1/`</pre>
>   - Click **Continue >**
> - **3) Pipeline Input**
>   - **Stage: IaCM**
>     - Workspace: `demoworkspace`
> - Click **Create Trigger >**

<br>

> ## Switch to the [button label=">_Shell" variant="success"](tab-2) tab to continue

## Create a new branch
```bash,run
cd iacm-repo/
git checkout -b demo
```

> ## Switch to the [button label="Code Editor" variant="success"](tab-1) tab to continue

## Now let's add a new resource to test out our trigger
> **Update `gcp/v1` **>** `resources.tf` file**
> - Scroll to the bottom of the file
>   - Add the resource below ↓
```hcl
resource "google_storage_bucket" "demo_bucket" {
  name     = "[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]"
  location = "[[ Instruqt-Var key="HARNESS_GCP_REGION" hostname="sandbox" ]]"

  labels = {
    owner = "[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]"
  }
}
```

> 1) Click on `Source Control` tab on the left nav \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/vs_code_commit.png)
> 2) Enter your commit message e.g., <pre>`added gcs bucket`</pre>
> 3) Click the dropdown `v`
> 4) Click `Commit & Push`
> - Click `Yes` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/vs_code_stage_changes.png)
> - Click `OK` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/vs_code_remote_branch.png)

> ## Switch to the [button label="Harness Platform" variant="success"](tab-0) tab to continue

## Time to open a PR
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/module_code.png)

Select the **Code Repository** module from the list <br>

> - Click on our **iacm-repo** \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_code_repo.png)
> - Click on **Pull Requests** in the left Nav
> - Click `+New Pull Request` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_new_pull_request.png)
> - Select a branch here: `demo` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_pr_open.png)
> - Click on **Create pull request**
> - This will activate our `pipeline trigger` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_pr_checks.png)

> [!IMPORTANT]
> *What information do you think will be shown here?*

<br><br>

> [!NOTE]
> After a minute or so we will see your PR decorated \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_pr_planned_changes.png)

<br><br>

# Congratulations on completing this `Harness IaCM` workshop!
> [!IMPORTANT]
> That's all for now. We hope you enjoyed your hands-on experience with the Harness IaCM module. We are always looking to improve so please rate your experience and share any suggestions or issues you may have encountered. Thank you!

===============

Click the **Check** button to continue.
