---
slug: lab2-build
id: ozdu1gvrnel1
type: challenge
title: Lab 2 - Building the Application
teaser: Learn how to build your application using Harness, including setting up build
  steps, managing build artifacts, and configuring build environments.
notes:
- type: text
  contents: |
    - Configure a basic pipeline using Harness CIE
    - Build and Deploy an artifact to a remote repository using Harness CIE
    - Run unit tests during the process to verify that the build is successful using Harness CIE
tabs:
- id: gr1z3bsmyauj
  title: Harness Platform
  type: browser
  hostname: harness
- id: 9bvnh8ysgwro
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: pilaxvjie6nc
  title: Shell
  type: terminal
  hostname: sandbox
- id: h6ycwffx5pfw
  title: Notes
  type: code
  hostname: sandbox
  path: /root/notes
- id: 36rgbjwvikrr
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
</style><h2 class="cyan">Setup a CI Pipeline</h2>
<hr class="cyan">
<br><br>

## Let's create a pipeline
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/module_unified.png)

Select **Unified View** from the list <br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/nav_pipelines.png)
> ### Click on **Pipelines** in the left Nav
> - Click `+Create Pipeline` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_create.png)

> **Create new Pipeline**
> - Name: `Workshop Build and Deploy`
> - Store: `Inline`

Click `+Add Stage` <br>

> Choose **Build** stage type <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_stage_build.png)

> **Build Stage**
> - Stage Name: `Build`
> - Clone Codebase: `Enabled`
> - Repository Name: `harnessrepo`
> - Click **Set Up Stage**

<br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_infrastructure.png)
> ### On the  **Infrastructure** tab
> - Select `Cloud` and click **Continue >**

<br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_execution.png)
> ### On the  **Execution** tab
> - Select `Add Step`, then `Add Step` again \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_pipeline_build_run_tests_step.png)
> - Select `Run Tests` from the Step Library and configure with the details below ↓


> **Run Tests**
> - Name: `Run Tests With Intelligence`
> - Language: `Python`
> - Build Tool: `Pytest`
> - Build Arguments: `Leave empty`
> - **Additional Configuration  ⏷**
>   - Pre-Command: `pip install pytest & cd ./python-tests`
>   - Run only selected tests: `Enabled`
> - After completing configuration select **Apply Changes** from the top right of the configuration popup

### What is Test Intelligence?
Test Intelligence helps accelerate test cycles by up to 80%. By running only relevant tests, you can achieve faster builds, shorter feedback loops, and significant cost savings.

> ### Add a step to compile our application
> - Select `Add Step`,  then `Use template`
>   - To standardize our build, a template has been precreated
>     - Feel free to open up the template if you'd like to see what it's doing
> - Select the `Compile Application` template and click `Use template`
> - Name: `Compile`
> - Click **Apply Changes** from the top right of the configuration popup

> ### Add a step to build and push our artifact
> - Select `Add Step`, then `Add Step` again \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_pipeline_build_dockerhub.png)
> - Select `Build and Push an image to Dockerhub` from the Step Library and configure with the details below ↓

> **Build and Push an image to Dockerhub**
> - Name: `Push to Dockerhub`
> - Docker Connector: `workshop-docker`
> - Docker Repository: `seworkshop/harness-workshop`
> - Tags: Click `+ Add`
>   - `<+variable.username>-<+pipeline.sequenceId>`
> - **Optional Configuration  ⏷** *(Required for this Lab)*
>   - Dockerfile: `/harness/frontend-app/harness-webapp/Dockerfile`
>   - Context: `/harness/frontend-app/harness-webapp`
> - After completing configuration select **Apply Changes** from the top right of the configuration popup

### Execute your new Pipeline
> Click **Save** in the top right to save your new pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_save.png)

> Now click **Run** to execute the pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_run.png)

> The build should run using: <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted_lab2_execution.png)
> - Branch Name: `main`

===============

Click the **Check** button to continue.
