---
slug: integrating-security
id: tl8e0qcke7l0
type: challenge
title: Lab 4 - Security Testing Orchestration
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
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/sto_pipeline.png">
      <ul class="features-list">
        <li>Orchestrate Security Scans in the Pipeline</li>
        <li>Rapidly Prioritize Vulnerabilities</li>
        <li>Fix Fast with AI Remediation Guidance</li>
      </ul>
    </div>
tabs:
- id: ghowd3ydrygf
  title: Harness Platform
  type: browser
  hostname: harness
- id: r8yqha3jdsxg
  title: Demo App
  type: website
  url: https://${_SANDBOX_ID}.instruqt.harness-demo.site/
- id: 68crixqd4tom
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: gwgaslawncru
  title: Shell
  type: terminal
  hostname: sandbox
- id: slgrwmiinigp
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

## Now let's add Harness Built-in Scanners
Harness offers robust and versatile solutions tailored to meet the stringent demands of even the most discerning security professionals.

> Go back to the **Harness** `Pipeline Studio` by clicking the **Edit Pipeline** button \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_edit.png)

### Adding SCA Scanners
===
> 1) In the existing pipeline, within the ***Build*** stage `after` the ***Compile*** step click on `+ Add Step` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_gar_build_add_sca_step.png)
> 1) Select `Add Step` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/unscripted/unscripted_pipeline_build_add_step_buitin_scanners.png)
> 1) Select `Built-in Scanners` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/sto_built_in_scanner_sca.png)
> 1) Select `SCA`
> 1) Click **Add Scanners**
> 1) Select the steps we just added
>    1) Rename the steps to  <pre>`OWASP`</pre> and <pre>`OSV Scan`</pre>
>    1) Click **Apply Changes** in the top right after renaming each

### Adding Container Image Scanner
===
> 1) In the existing pipeline, within the ***Build*** stage `after` the ***Push to Google Artifact Registry*** step click on `+ Add Step` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_add_step.png)
> 1) Select `Add Step` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/unscripted/unscripted_pipeline_build_add_step_buitin_scanners.png)
> 1) Select `Built-in Scanners` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/sto_built_in_scanner_container.png)
> 1) Select `Container` from the Step Library and configure with the details below ↓

> **Built-in Container Scanners**
> - Check: `Aqua Trivy`
>   - *`Uncheck` the other scanners*
> - **Container Information**
>   - Type: `Docker V2`
>   - Image: <pre><code>seworkshop/seworkshop/harness-workshop:<+variable.username>-<+pipeline.sequenceId></pre></code>
> - Click **Add Scanners**

> 1) Select the step we just added
>    1) Rename the step to <pre>`Aqua Trivy`</pre>
>    1) Under the ***Container Image*** section update
>       1) Domain: <pre><code>us-docker.pkg.dev</pre></code>
>    1) Click **Apply Changes** in the top right
> 1) Then click on the `dind` step \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_step_dind.png) \
>    and configure with the details below ↓

> **Configure Background Step**
> - **Additional Configuration  ⏷**
>   - Container Registry: `workshop-docker`
>   - (You may need to click the `All` or `Org` tab to see the registry)
> - Click **Apply Changes** in the top right

### DAST Scan Template Owned by the Security Team
===
Now we are going to add a `Stage` template to run DAST Scans.

> [!NOTE]
> Typically, the security team owns these scans, and as such, they will manage and version the template as needed. They simply require that we include it in our pipeline.

> 1) In the existing pipeline, click on the `+` icon under the ***Backend - Deployment*** stage to add a new stage \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/unscripted/unscripted_pipeline_add_sto_stage.png)<br>
> 1) Select `Use template` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_stage_use_template.png)
> 1) Select `DAST Scans` template and click `Use template`
> 1) Name the stage <pre>`DAST Scans`</pre>

<br>

### Execute your updated Pipeline
===
> Click **Save** in the top right to save your pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_save.png)

> Now click **Run** to execute the pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_run.png)

### Security Scan Results
The scans take ~3 minutes to run. <br>
After the execution is complete, go to the `Security Tests` tab to see the *deduplicated*, *normalized* and *prioritized* list of `vulnerabilities` discovered across your scanners. <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/unscripted/unscripted_pipeline_security_tests_tab.png)

Conclusion
===

Click the **Check** button to continue.

***BONUS***
===
### Adding SAST Scanner
> 1) In the existing pipeline, within the ***Build*** stage `under` the ***OSV Scan*** step click on `+ Add Step` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_add_step.png)
> 1) Select `Add Step` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/unscripted/unscripted_pipeline_build_add_step_buitin_scanners.png)
> 1) Select `Built-in Scanners` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/sto_built_in_scanner_sast.png)
> 1) Select `SAST` and click **Add Scanner**
> 1) Rename the step to `Semgrep`

===============

Click the **Check** button to continue.
