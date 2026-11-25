---
slug: workspace-templates
id: jaip23synspr
type: challenge
title: Lab 9 - Workspace Templates
teaser: Harness IaCM Workspace Templates make it easy to consume standard golden/paved
  architectures
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
      <h1>Use  a Workspace Template</h1>
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/iac_workspace.png">
      <ul class="features-list">
        <li>Harness IaCM Workspace Templates make it easy to consume standard golden/paved architectures</li>
      </ul>
    </div>
tabs:
- id: yy4llkkj35fa
  title: Harness Platform
  type: browser
  hostname: harness
- id: 1dheotgrh0w7
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: keuxwxupmvxu
  title: Shell
  type: terminal
  hostname: sandbox
- id: aza4ss0n5vmz
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
difficulty: ""
timelimit: 1600
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">PR Triggers and Validation</h2>
<hr class="cyan">
<br>

## Let's create a workspace from a standard templated architecture
> - Click on **Workspaces** in the left Nav
> - Click the `+New Workspace` button and select `Start with Template`\
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_start_with_template.png)

> **New Workspace**
> - Name: <pre>`workspace-from-template`</pre>
> - Click **Start**
> - Select the `Standard 3x AWS EC2` template and then click on the `Use Template` button
> -  In your new workspace, select the  **Connectors and Variables** tab

> [!NOTE]
> Note that there are two variables, but only one is editable. Template owners are able to mark each variable in the template as editable by the consumers of the template or not. This allows the infrastructure team to provide flexibility to their consumers and while still maintaining control of settings that should be centrally defined.
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/se-workshop-iacm/assets/images/iacm_templated_variables.png)

>  - On the right hand side of the tab, click **+ Add Connector**
>  - Click the select box that appears just below the **+ Add Connectors** button and select  the `instruqt-workshop-connector` connector.
>  - Click on the **Save Changes** button

> Now we can provision our workspace!
> - Click on **Pipelines** in the left Nav
> - Click on the **IaCM Provision** pipeline
> - Click **Run** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/pipeline_run.png)
> - Then select your `workspacefromtemplate` **Workspace** to execute the pipeline
> - Click **Run Pipeline**
> - Review and approve the changes

<br>
NOTE: Now sit back, grab a coffee and wait until the instructor catches up and says that it's time to continue
<br>

> - In your existing pipeline execution, click the `**Re-run**` button

<br>
<br>

# Congratulations on completing this `Harness IaCM` workshop!
> [!IMPORTANT]
> That's all for now. We hope you enjoyed your hands-on experience with the Harness IaCM module. We are always looking to improve so please rate your experience and share any suggestions or issues you may have encountered. Thank you!

===============

Click the **Check** button to continue.
