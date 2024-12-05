---
slug: lab2-creating-a-workspace
id: t5szntukrxxo
type: challenge
title: Lab 2 - Creating a Workspace
teaser: Setting up your first IaCM Workspace
notes:
- type: text
  contents: |
    In this lab, participants will learn how to create and configure a workspace in Harness IaCM. This will serve as the foundation for the subsequent labs, where you will manage your infrastructure as code.
tabs:
- id: pmno5w3gstut
  title: Harness Platform
  type: browser
  hostname: harness
- id: y1iw60xywo6j
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: ufxishevdowu
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
</style><h2 class="cyan">Create an IaCM Workspace</h2>
<hr class="cyan">
<br>

## Now it's time to create an IaCM Workspace
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/module_iacm.png)

Select the **Infrastructure as Code Management** module from the list <br>

Click on **Workspaces** in the left Nav <br>
And then click `+New Workspace` <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_new_workspace.png)

> **New Workspace**
> - Name: <pre>`demo-workspace`</pre>
> - Cloud Cost Estimation: `ON`
> - **Provisioner**
>   - Connector: `instruqt-workshop-connector`
>   - Type: `Terraform`
>   - Version: `1.5.7`
> - **Repository**
>   - Select Git Provider: `Harness Code Repository`
>   - Select Repository: `iacm-repo`
>   - Git Fetch Type: `Latest from Branch`
>   - Branch: `main`
>   - Folder Path: <pre>`aws/v1`</pre>
> - Click **Save**

> **Configure Workspace**
> - Click on the **Variables** tab
> - And then click on **Terraform Variables** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_workspace_variables.png)
> - Click `+New Terraform Variable`
>     | Key           | Value     |
>     |---------------|-----------|
>     | <pre>`instance_type`</pre> | <pre>`t2.micro`</pre> |
> - Click ✅ to save this variable

> [!IMPORTANT]
> You could also reference a variable file from another location or another repository entirely!

===============

Click the **Check** button to continue.
