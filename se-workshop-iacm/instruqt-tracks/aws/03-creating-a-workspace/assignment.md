---
slug: creating-a-workspace
id: xqthwgrrvneg
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
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iac_workspace.png">
      <ul class="features-list">
        <li>A workspace is a named environment that stores Terraform configurations, variables, states, and other resources necessary to manage infrastructure.</li>
      </ul>
    </div>
tabs:
- id: unsv3uj54c1p
  title: Harness Platform
  type: browser
  hostname: harness
- id: e8yycfpa4p3f
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: 6pjxbxpj6yrx
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
<br><br>

## Now it's time to create an IaCM Workspace

Select the **Infrastructure as Code Management** module from the module selector menu <br>

![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/module_iacm.png)

- Click  <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iacm/new_workspace_1.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;">  and configure as follows

  > **Create New Workspace**<br><br>
  > - **About Workspace**<br><br>
  >   - Name: `demo-workspace`
  >   - Click **Next**<br><br>
  > - **Configure Repository Details**<br><br>
  >   - Select Git Provider: `Harness Code Repository`
  >   - Select Repository: `iacm-repo`
  >   - Git Fetch Type: `Latest from Branch`
  >   - Branch: `main`
  >   - Folder Path: `aws/v1`
  >   - Click **Next**<br><br>
  > - **Provisioner**<br><br>
  >   - Connector: `instruqt-workshop-connector`
  >   - Cloud Cost Estimation: `ON`
  >   - Type: `OpenTofu`
  >   - Version: `1.10.6`
  >   - Click **Create**
  
<br>
Your newly created workspace will be opened in the editor. 

- Click on the **Connectors and Variables** tab

- Click  <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iacm/add_variable.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;">  in the **Terraform Variables** section<br><br>
      ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_workspace_variables.png)

- Configure the variable as follows
  > - Key: `instance_type`
  >
  > - Value: `t2.micro`

- Click  <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iacm/save_changes.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> 

> [!IMPORTANT]
> You could also reference a variable file from another location or another repository entirely!

===============

Click the **Check** button to continue.
