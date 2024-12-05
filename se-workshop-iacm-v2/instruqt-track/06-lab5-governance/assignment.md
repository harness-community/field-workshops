---
slug: lab5-governance
id: zbcpy1swdrq6
type: challenge
title: Lab 5 - Governance
teaser: Using OPA policy to limit Terraform variables
notes:
- type: text
  contents: |
    Explore how to integrate Open Policy Agent (OPA) with Harness IaCM to enforce governance policies. This lab will demonstrate setting up policy-as-code frameworks to ensure compliance across your infrastructure deployments.
tabs:
- id: wvglh0v0bydi
  title: Harness Platform
  type: browser
  hostname: harness
- id: tp2hysqzxkox
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: 7u5qhme4xdtv
  title: Shell
  type: terminal
  hostname: sandbox
- id: g9mkzjejyqdi
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
</style><h2 class="cyan">Guardrails through OPA Policy</h2>
<hr class="cyan">
<br>

## Now let's configure a policy
> - Click on **Project Settings** in the left Nav
> - Scroll down to **Security and Governance**
> - Click on **Policies**
> - Click the **X** in the top right corner to close out of the quick start
> - This is the Overview screen
>   - In the top right of this screen click **Policies** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/opa_new_policy.png)
>   - Then click `+New Policy`and configure with the details below ↓

> **Policy Name**
> - Name: <pre>`Restrict AWS EC2 Instance Size`</pre>
> - Store: `Inline`
> - Click **Apply**
> - Paste in the `OPA Rego Policy` below ↓
```
package workspaces

# Define the list of allowed instance types
allowed_instance_types := {"t2.micro", "t3.micro", "t3.small"}

# deny
deny[msg] {
  instance_type = input.workspace.terraform_variables.instance_type
  not allowed_instance_types[instance_type.value]
  instance_types_array := [type | type := allowed_instance_types[_]]
  msg := sprintf("Only machine types of: %v are allowed per the policy", [instance_types_array])
}
```
> - After completing configuration select **Save** from the top right to save your new policy

> [!NOTE]
> *What does this policy accomplish?*

### Create new Policy Set
In the top right of this screen click **Policy Sets** <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/opa_new_policy_set.png)<br>
And then click `+New Policy Set` <br>

> **Policy Set**
> - **Overview**
>   - Name: <pre>`Prevent Non Standard EC2 Instance Sizes`</pre>
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

> [!IMPORTANT]
> - Be sure to click the toggle under `ENFORCED` to enable your **Policy Set** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/opa_policy_toggle.png)

### Let's test it out
Head back over to your workspace. <br>

> **Configure Workspace**
> - Click on the **Variables** tab
> - And then click on **Terraform Variables** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_workspace_variables.png)
> - Click the **pencil** icon next to `instance_type`
> - Change the value to <pre>`t2.large`</pre>
> - Click ✅ to save this variable

> [!NOTE]
> That is `Policy as Code` in action! Isn't it beautiful? <br>
> Harness has wrapped the ***entire platform*** with `OPA` so this is just the tip of the iceberg!

===============

Click the **Check** button to continue.
