---
slug: lab4-governance
id: gg8laxwwyqek
type: challenge
title: Lab 4 - Governance
teaser: Using OPA policy to limit Terraform variables
notes:
- type: text
  contents: |
    Explore how to integrate Open Policy Agent (OPA) with Harness IaCM to enforce governance policies. This lab will demonstrate setting up policy-as-code frameworks to ensure compliance across your infrastructure deployments.
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
</style><h2 class="cyan">Guardrails through OPA Policy</h2>
<hr class="cyan">
<br>

## Now let's configure a policy
Click on **Project Settings** in the left Nav <br>
Then scroll down to **Security and Governance** and click **Policies** <br>
Click the **X** in the top right corner to close out of the quick start  <br><br>
This is the Overview screen. In the top right of this screen click **Policies** <br>
> ![New_Policy.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/New_Policy.png)
And then click ```+New Policy``` <br>

### Create new Policy
> **Policy Name**
> - Name: ```Restrict AWS EC2 Instance Size``` <br>
> - Store: ```Inline``` <br>

#### OPA Rego Policy
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
Click **Save** in the top right to save your new policy <br>

### Create new Policy Set
In the top right of this screen click **Policy Sets** <br>
> ![New_Policy_Set.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/New_Policy_Set.png)<br>
And then click ```+New Policy Set``` <br>

> **Policy Set**
> - **Overview** <br>
> -- Name: ```Prevent Non Standard EC2 Instance Sizes``` <br>
> -- Entity Type: ```Workspace``` <br>
> -- Evaluation: ```On Save``` <br>
> - **Policy evaluation criteria** <br>
> -- Policy to Evaluate: ```Restrict AWS EC2 Instance Size``` <br>
> -- Policy Action: ```Error and exit``` <br>
Click **Finish** to save your **Policy Set** <br>

> ![Policy_Toggle.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/Policy_Toggle.png)<br>
Be sure to click the toggle under **ENFORCED** to enable your **Policy Set**

### Let's test it out
Head back over to your workspace. <br>
> Click on **Variables** and then on **Terraform Variables** <br>

Click the pencil icon next to ```instance_type``` and try to change the value to ```t2.large``` and then click the green check mark to save it.
<br><br>
That is `Policy as Code` in action! Isn't it beautiful? <br>
Harness has wrapped the *entire platform* with `OPA` so this is just the tip of the iceberg! <br>

===============

Click the **Check** button to continue.
