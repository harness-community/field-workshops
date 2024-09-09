---
slug: lab5-devsecops
id: tlmipjarfdty
type: challenge
title: Lab 5 - Integrating Security
teaser: Shift-left and integrate security scanners into your pipelines, using Harness
  to automate vulnerability scanning, compliance checks, and other security measures.
notes:
- type: text
  contents: |
    - **Time-Consuming Analysis:** Developers often find it overwhelming and time-consuming to manually go through detailed reports from multiple scanners, especially when addressing vulnerabilities across different scan types (SCA, SAST, Container Image, DAST).
    - **Duplication and Overlap:** There can be potential duplication of findings across reports, leading to confusion and inefficiency as developers may spend time re-investigating and remediating issues that appear in multiple reports but are essentially the same vulnerability.
    <br>
    ## **Harness** streamlines and simplifies this entire process eliminating the toil and keep developers doing what they do best, writing code!
tabs:
- id: 2y7dt1fkfxx4
  title: Harness Platform
  type: browser
  hostname: harness
- id: wtyrmgosehfb
  title: Demo App
  type: website
  url: https://sandbox-8080-${_SANDBOX_ID}.env.play.instruqt.com/
- id: fuukhtvmbcsj
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: ljmepaddw6my
  title: Shell
  type: terminal
  hostname: sandbox
- id: 6cvvdnz0yxgy
  title: Notes
  type: code
  hostname: sandbox
  path: /root/notes
- id: uefcoov97q9k
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
difficulty: basic
timelimit: 1600
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Integrate Security Scanners</h2>
<hr class="cyan">
<br><br>

## Integrating Security Scans
Harness offers robust and versatile solutions tailored to meet the stringent demands of even the most discerning security professionals.
### Go back to the `Pipeline Studio` and edit your pipeline

## Harness Built-in Scanners
### Adding SCA Scanners
> 1) In the existing pipeline, within the ***Build*** stage `after` the ***Compile*** step click on `+ Add Step` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_pipeline_build_add_sca_step.png)
> 2) Select `Add Step` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_pipeline_build_add_step_buitin_scanners.png)
> 3) Select `Built-in Scanners` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/sto_built_in_scanner_sca.png)
> 4) Select `SCA` and click **Add Scanners**
> 5) Rename the steps to <pre>`OWASP`</pre> and <pre>`OSV Scan`</pre>

### Adding Container Image Scanner
> 1) In the existing pipeline, within the ***Build*** stage `after` the ***Push To Dockerhub*** step click on `+ Add Step` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_add_step.png)
> 2) Select `Add Step` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_pipeline_build_add_step_buitin_scanners.png)
> 3) Select `Built-in Scanners` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/sto_built_in_scanner_container.png)
> 4) Select `Container` from the Step Library and configure with the details below ↓
>
> **Built-in Container Scanners**
> - Check: `Aqua Trivy`
>   - *Uncheck the other scanners*
> - **Container Information**
>   - Type: `Docker V2`
>   - Image: <pre><code>seworkshop/harness-workshop:<+variable.username>-<+pipeline.sequenceId></pre></code>
> - After completing configuration select **Add Scanners**
>
> 5) Rename the step to <pre>`Aqua Trivy`</pre>
> 6) Then click on the `dind` step \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_step_dind.png) \
>    and configure with the details below ↓
> **Configure Background Step**
> - **Additional Configuration  ⏷**
>   - Container Registry: `workshop-docker`
>   - (You may need to click the `All` or `Org` tab to see the registry)
> - Click **Apply Changes** from the top right of the configuration popup

### DAST Scan Template Owned by the Security Team
Now we are going to add a `Stage` template to run DAST Scans.

> [!NOTE]
> Typically, the security team owns these scans, and as such, they will manage and version the template as needed. They simply require that we include it in our pipeline.

> 1) In the existing pipeline, click on the `+` icon under the ***Backend - Deployment*** stage to add a new stage \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_pipeline_add_sto_stage.png)<br>
> 2) Select `Use template` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_stage_use_template.png)
> 3) Select `DAST Scans` template and click `Use template`
> 4) Name the stage <pre>`DAST Scans`</pre>

<br>

### Execute your updated Pipeline
> Click **Save** in the top right to save your pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_save.png)

> Now click **Run** to execute the pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_run.png)

### Security Scan Results
The scans take ~3 minutes to run. <br>
After the execution is complete, go to the `Security Tests` tab to see the *deduplicated*, *normalized* and *prioritized* list of `vulnerabilities` discovered across your scanners. <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_pipeline_security_tests_tab.png)

## ***BONUS***
### Adding SAST Scanner
> 1) In the existing pipeline, within the ***Build*** stage `under` the ***OSV Scan*** step click on `+ Add Step` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_add_step.png)
> 2) Select `Add Step` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_pipeline_build_add_step_buitin_scanners.png)
> 3) Select `Built-in Scanners` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/sto_built_in_scanner_sast.png)
> 4) Select `SAST` and click **Add Scanner**
> 5) Rename the step to `Semgrep`

===============

Click the **Check** button to continue.
