---
slug: governance
id: nsopiqok447r
type: challenge
title: Lab 6 - Governance
teaser: Using OPA policy to limit Terraform variables
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

      .sub-container {
        display: flex;
        flex-direction: row;
        align-items: flex-start;
      }

      .harness-image {
        max-width: 90%;
        max-height: 55%;
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

      .features-list .sub-list {
        list-style-type: disc;
        margin-left: 20px;
        font-weight: normal;
        font-size: 20px;
        font-style: italic;
      }

      @media (max-width: 768px) {
        .features-list li {
          font-size: 1.25rem;
        }

        .features-list .sub-list {
          font-size: 1.25rem;
        }
      }

      @media (max-width: 480px) {
        .features-list li {
          font-size: 1rem;
        }

        .features-list .sub-list {
          font-size: 1rem;
        }
    </style>

    <br>
    <div class="container">
      <h1>Guardrail your deployments</h1>
      <div class="sub-container">
        <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/cd_opa_guardrails.avif">
        <ul class="features-list">
          <li>Flexible policies using Open Policy Agent</li>
          <li>Give developers permission to edit pipelines while central teams dictate rules like:
            <ul class="sub-list">
              <li>All production deployments must have an approval step</li>
              <li>Only certain instance sizes or families are allowed</li>
            </ul>
          </li>
          <li>With OPA, teams can be empowered while scalable guardrails ensure compliance</li>
        </ul>
      </div>
    </div>
tabs:
- id: 3z9dduengrg9
  title: Harness Platform
  type: browser
  hostname: harness
- id: snz2goz7b5bf
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: pa2xgwkklnga
  title: Shell
  type: terminal
  hostname: sandbox
- id: zanfxu3uyvty
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
</style><h2 class="cyan">Lab 6 - Governance</h2>
<hr class="cyan">
<br>

Create a Policy
===

- Click on **Project Settings** in the left Nav
- Scroll down to **Security and Governance**
- Click on **Policies**
- Click the **X** in the top right corner to close out of the quick start
- On the top right side of the overview screen, click on the **Policies** tab
- Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/new_policy.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> and configure as follows

> **Policy Name**
> - Name: `Restrict AWS EC2 Instance Size`
> - Store: `Inline`
> - Click **Apply**
> - Paste in the `OPA Rego Policy` below
> ```
> package workspaces
>
> # Define the list of allowed instance types
> allowed_instance_types := {"t2.micro", "t3.micro", "t3.small"}
>
> # deny
> deny[msg] {
>   instance_type = input.workspace.terraform_variables.instance_type
>   not allowed_instance_types[instance_type.value]
>   instance_types_array := [type | type := allowed_instance_types[_]]
>   msg := sprintf("Only machine types of: %v are allowed per the policy", [instance_types_array])
> }
> ```

- Click  **Save** from the top right to save your new policy

> [!NOTE]
> *What does this policy accomplish?*

Create a Policy Set
===

### Create new Policy Set
- On the top right side of the overview screen, click on the **Policy Sets** tab
- Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/new_policy_set.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> and configure as follows

> **Policy Set**
> - **Overview**
>   - Name: `Prevent Non Standard EC2 Instance Sizes`
>   - Entity Type: `Workspace`
>   - Evaluation: `On Save`
>   - Click **Continue**
> - **Policy evaluation criteria**
>   - Click `+Add Policy`
>   - **Select Policy**
>     - Policy to Evaluate: `Restrict AWS EC2 Instance Size`
>     - Policy Action: `Error and exit`
>     - Click `Apply`
>   - Click `Finish`

- Click the  **ENFORCED** toggle to make sure that the Policy Set is enabled/enforced
![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/opa_policy_toggle.png)

Test the Policy
===
### Let's test it out
Head back over to your workspace. <br>
- Click **Workspaces** in the left Nav
- Click into **demo-workspace**
- Click on the **Connectors and Variables** tab
- Under the **Terraform Variables** section, change the value for the **instance_type** variable to `t2.large`
- Click  <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iacm/save_changes.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;">

> [!NOTE]
> Did your change get saved? No, because it didn't meet the requirements of your policy.
>
> That is **Policy as Code** in action! Isn't it beautiful? <br>
> Harness has wrapped the ***entire platform*** with ***Open Policy Agent (OPA)*** so this is just the tip of the iceberg!

- Click the **X** in the top right corner to close out of the ***Policy Set Evaluations***

===============

Click the **Check** button to continue.
