---
slug: pr-validation
id: pzubgof2q5oy
type: challenge
title: Lab 8 - PR Triggers and Validation
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
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iac_pr_automation.png">
      <ul class="features-list">
        <li>By implementing PR automation, developers significantly reduce the likelihood of errors when making resource changes. This capability brings the visibility of planned changes into the PR process.</li>
      </ul>
    </div>
tabs:
- id: ojndx6lidxl3
  title: Harness Platform
  type: browser
  hostname: harness
- id: c2z7p04wg9pt
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: es61grp5ntyk
  title: Shell
  type: terminal
  hostname: sandbox
- id: 2ttte9jj2jey
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
</style><h2 class="cyan">Pull Request Automation</h2>
<hr class="cyan">
<br>

Create a Pull Request Pipeline
===
- Click on **Pipelines** in the left Nav

- Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/create_a_pipeline.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> and configure as follows

  > **Create new Pipeline**
  >
  > - Name: `IaCM Pull Request`
  >
  > - Store: `Inline`
  >
  > - Click **Start**


In the newly created pipeline, perform the following steps:

- Click `+Add Stage`

- Choose **Infrastructure** stage type and configure as follows

  > ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_pipeline_stage.png)
  > **About your Stage** <br><br>
  > - Stage Name: `IaCM` <br><br>
  > - Click **Set Up Stage**

In the newly created stage, configure as follows:


  > **Infrastructure**<br><br>
  > - Infrastructure: **Cloud**<br><br>
  > - Click **Next >**
  >
  > <br>**Input**<br><br>
  > - **Workspace**: set the type to `Runtime input` by clicking on the pin icon next to the field. <br><br>*Note that you may get a tooltip that explains the different input types. If so, please close the tooltip in order to access the pin icon.*
  >
  >     ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iacm/workspace_runtime_input.png)
  >
  > - Click **Next >**
  > <br>
  >
  >**Operations**<br><br>
  > - Select **Pull Request** operation<br>
  >   ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_pr_step.png)
  >
  > - Click **Use Operation**
  >
- Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/save_pipeline.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> in the top right to save the pipeline

Create a Pipeline Trigger
===
- Click on **Triggers** in the top right of the pipeline editor
- Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/new_trigger.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;">
- Select **Harness** under the **Webhook** section and configure as follows

>   - **Trigger Configuration: On New Webhook**
>     - Name: `Pull Request`
>   - **Listen on New Webhook**
>     - Repository: `iacm-repo`
>     - Event: `Pull Request`
>     - Actions: `Create`
>     - Click **Continue >**
> - **Conditions**
>     - Attribute: `Changed Files`
>     - Operator: `Starts With`
>     - Matches Value: `aws/v1`
>     - Click **Continue >**
> - **Pipeline Input**
>   - **Stage: IaCM**
>     - Workspace: `demoworkspace`
>    - Click **Create Trigger >**

Update the Code and Create a Pull Request
===
> ## Switch to the [button label="Code Editor" variant="success"](tab-1) tab to continue

## Add a new resource to test out our trigger
- Open the **aws/v1/resources.tf** file
- Paste the following at the bottom of the file and save
```hcl
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]"

  tags = {
    Name        = "[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]"
    Environment = "Demo"
  }
}
```

> ## Switch to the [button label=">_Shell" variant="success"](tab-2) tab to continue

## Create a new branch and push your code
```bash,run
cd iacm-repo
git checkout -b demo
git add *
git commit -m "added s3 bucket"
git push origin demo
```


> ## Switch to the [button label="Harness Platform" variant="success"](tab-0) tab to continue

## Create a Pull Request and review
- Select the **Code Repository** module from the list <br>
  ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/module_code.png)
- Click into the **iacm-repo** repo
- Click **Pull Requests** in the left Nav
- Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/hcr/hcr_new_pull_request.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> 
- In the dropdown labeled `select a branch here`, select `demo` as the branch
	![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/hcr/hcr_select_a_branch_here.png)
- Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/hcr/hcr_create_pull_request.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> 

<br>

Based on the trigger that we created earlier, this PR will automatically run the **IaCM Pull Request** pipeline


- Click the <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/hcr/hcr_checks.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;">  tab
- Review the progress of the pipeline
- Once the check/pipeline is complete, click on the <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/hcr/hcr_conversation.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;">  tab

<br>

Harness has decorated the PR with change information so that you can review without having to go to the pipeline
  ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_pr_planned_changes.png)


<br>


===============

Click the **Check** button to continue.
