---
slug: lab2-creating-a-workspace
id: ymogqrrog4hp
type: challenge
title: Lab 2 - Creating a Workspace
teaser: Setting up your first IaCM Workspace
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
      <h1>Create a Workspace</h1>
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/iac_workspace.png">
      <ul class="features-list">
        <li>A workspace is a named environment that stores Terraform configurations, variables, states, and other resources necessary to manage infrastructure.</li>
      </ul>
    </div>
tabs:
- id: 4kvvbl7z3asd
  title: Harness Platform
  type: browser
  hostname: harness
- id: criau5j1x3m4
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: qewe0dlkzmw2
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
>   - Folder Path: <pre>`gcp/v1`</pre>
> - Click **Save**

> **Configure Workspace**
> - Click on the **Variables** tab
> - And then click on **Terraform Variables** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_workspace_variables.png)
> - Click `+New Terraform Variable`
>     | Key           | Value     |
>     |---------------|-----------|
>     | <pre>`instance_type`</pre> | <pre>`e2-micro`</pre> |
> - Click ✅ to save this variable
> - Click `+New Terraform Variable`
>     | Key           | Value     |
>     |---------------|-----------|
>     | <pre>`gcp_project_id`</pre> | <pre>`[[ Instruqt-Var key="HARNESS_GCP_PROJECT_ID" hostname="sandbox" ]]`</pre> |
> - Click ✅ to save this variable

> [!IMPORTANT]
> You could also reference a variable file from another location or another repository entirely!

===============

Click the **Check** button to continue.
