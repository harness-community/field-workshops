---
slug: lab1-creating-a-workspace
id: cacladdx8lkl
type: challenge
title: Lab 1 - Creating a Workspace
teaser: Setting up your first IaCM Workspace
notes:
- type: text
  contents: |
    In this lab, participants will learn how to create and configure a workspace in Harness IaCM. This will serve as the foundation for the subsequent labs, where you will manage your infrastructure as code.
tabs:
- title: Harness Platform
  type: browser
  hostname: harness
- title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
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
</style><h2 class="cyan">Create an IaCM Workspace</h2>
<hr class="cyan">
<br>

> # Switch to the ```Code Editor``` tab to continue
From here we can take a look at our Terraform code to get a better understanding of what we will provision through an IaCM pipeline in the next lab.

<br><br>

> # Switch to the ```Harness Platform``` tab to continue

First let's select the project that's been created for this workshop <br>
![project_selection.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/project_selection.png)

## Now it's time to create an IaCM Workspace
![IaCM_Module.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/IaCM_Module.png)

Select the **Infrastructure as Code Management** module from the list <br>

Click on **Workspaces** in the left Nav <br>
And then click ```+New Workspace``` <br>
![New_Workspace.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/New_Workspace.png)


> **New Workspace**
> - Name: ```demo-workspace``` <br>
> - Cloud Cost Estimation: ```ON``` <br>
> - **Provisioner** <br>
> -- Connector: ```instruqt-workshop-connector``` <br>
> -- Type: ```Terraform``` <br>
> -- Version: ```1.5.6``` <br>
> - **Repository** <br>
> -- Connector: ```demo-github``` <br>
> -- Repository: ```harness-community/se-iacm-workshop``` <br>
> -- Git Fetch Type: ```Latest from Branch``` <br>
> -- Branch: ```main``` <br>
> -- File Path: ```aws/v1``` <br>

Click **Save**

### Configure Workspace
Click on the **Variables** tab <br>

> Add two ```Terraform Variables``` <br>
>
> | Key           | Value     |
> |---------------|-----------|
> | **instance_type** | `t2.micro` |
> | **extra**         | `test`     |


*You could also reference a variable file from another location or another repository entirely. By default, it looks for the ```variables.tf``` that is defined in Workspaces > Repo > File Path.*

===============

Click the **Check** button to continue.
