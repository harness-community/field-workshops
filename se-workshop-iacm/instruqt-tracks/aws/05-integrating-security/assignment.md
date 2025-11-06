---
slug: integrating-security
id: ou8jjvb2suun
type: challenge
title: Lab 5 - Security Testing Orchestration
teaser: Orchestrate security tests and remediate vulnerabilities with AI guidance.
notes:
- type: text
  contents: |-
    <style>
      .container {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        justify-content: center;
        height: 100vh;
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
      <h1>Comprehensive Built-In Security Testing Orchestration</h1>
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/sto_pipeline.png">
      <ul class="features-list">
        <li>Orchestrate Security Scans in the Pipeline</li>
        <li>Rapidly Prioritize Vulnerabilities</li>
        <li>Fix Fast with AI Remediation Guidance</li>
      </ul>
    </div>
tabs:
- id: eikfy8f7yyyp
  title: Harness Platform
  type: browser
  hostname: harness
- id: oq9x289xdlhc
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: wdx3a5uu2ocy
  title: Shell
  type: terminal
  hostname: sandbox
- id: f6vgxvkelxcc
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
</style><h2 class="cyan">Integrate Security Scanners</h2>
<hr class="cyan">
<br>

Ensuring that your infrastructure is secure and compliant is key to reducing risk for the organization. Harness IaCM makes it easy to integrate security into your infrastructure as code practice.
<br><br>

Add Security to Pipeline
===

## Now let's add a Security Scanner
Harness offers robust and versatile solutions tailored to meet the stringent demands of even the most discerning security professionals.

<br>

- In the existing pipeline execution, click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/execution_edit_button.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;">  at the top right of the screen to edit the pipeline
- Click on the ***IaCM*** stage
- Click on the **Execution** tab
- Hover over the pipeline between `plan` and `IACM Approval` and click `+`
![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-iacm/assets/images/iacm_pipeline_add_sto_step.png)
- Select `Add Step`
- Select `Wiz` and configure as follows:
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/pipeline_step_wiz.png)
> **Configure Wiz**<br><br>
>  - Name: Wiz Scan
> - Workspace: `/harness/aws`
> - **Authentication**<br><br>
>   - Access Id: `<+secrets.getValue("org.wiz_access_id")>`
>   - Access Token: `<+secrets.getValue("org.wiz_access_token")>`
>   <br><br>
> - Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/step_apply_changes.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> in the top right
<br>
- Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/save_pipeline.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> in the top right to save the pipeline


Execute the Pipeline
===

- To execute your pipeline, click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/run_pipeline.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> at the top right

- In the **Run Pipeline** dialog, select `demoworkspace` as the workspace

- Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/run_pipeline_2.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;">

- Wait for the **Wiz Scan** step to complete

- Click on the <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/platform/vulnerabilities_tab.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> tab to see the *deduplicated*, *normalized* and *prioritized* list of security issues discovered across your scanners. <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/iacm/iacm_vulnerabilities.png)

===============

Click the **Check** button to continue.
