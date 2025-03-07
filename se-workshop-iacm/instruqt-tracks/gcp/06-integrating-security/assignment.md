---
slug: integrating-security
id: xwfatg1wqcxh
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
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/sto_pipeline.png">
      <ul class="features-list">
        <li>Orchestrate Security Scans in the Pipeline</li>
        <li>Rapidly Prioritize Vulnerabilities</li>
        <li>Fix Fast with AI Remediation Guidance</li>
      </ul>
    </div>
tabs:
- id: rtvuxpegvdwv
  title: Harness Platform
  type: browser
  hostname: harness
- id: cxfys8wsguzb
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: wwx0xaiwapki
  title: Shell
  type: terminal
  hostname: sandbox
- id: jdcxgelba0ll
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
<br><br>

## Now let's add a Security Scanner
Harness offers robust and versatile solutions tailored to meet the stringent demands of even the most discerning security professionals.

> Click on **Pipelines** in the left Nav
> Click on pipeline: `IaCM Provision`

### Adding Wiz IaC Scan

> 1) In the existing pipeline, click on the ***IaCM*** stage
> 1) Click on the **Execution** tab \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_execution.png)
>    1) Hover over the pipeline between `plan` and `IACM Approval` and click `+` \
>        ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_pipeline_add_sto_step.png)
>    1) Select `Add Step`
>    1) Select `Wiz` \
>       ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_step_wiz.png)
>    1) Configure with the details below ↓

>    1) In the existing pipeline, click on the ***IaCM*** stage `after` the ***Plan*** step click on `+` \
>        ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_pipeline_add_sto_step.png)
>    1) Select `Add Step`
>    1) Select `Wiz` \
>       ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_step_wiz.png)
> 1) Configure with the details below ↓

> **Configure Wiz**
> - Type: <pre><code>`Wiz IaC Scan`</pre></code>
> - **Authentication**
>   - Access Id: <pre><code><+secrets.getValue("org.wiz_access_token")></pre></code>
>   - Access Token: <pre><code><+secrets.getValue("org.wiz_access_id")></pre></code>
> - Click **Apply Changes** in the top right

<br>

### Execute your updated Pipeline
> - Click **Save** in the top right to save your new pipeline \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_save.png)
> - Now click **Run** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_run.png)
> - Then select your `demoworkspace` **Workspace** to execute the pipeline
> - Click **Run Pipeline**

### Security Scan Results
The scans take ~3 minutes to run. <br>
After the execution is complete, go to the `Security Tests` tab to see the *deduplicated*, *normalized* and *prioritized* list of `vulnerabilities` discovered across your scanners. <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_pipeline_security_tests_tab.png)

===============

Click the **Check** button to continue.
