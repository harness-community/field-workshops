---
slug: migrate-to-harness
id: qgbxvlwvrycu
type: challenge
title: Lab 2 - Migrate to Harness
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

      .sub-container {
        display: flex;
        flex-direction: row;
        align-items: flex-start;
      }

      .harness-image {
        max-width: 90%;
        max-height: 55%;
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

      .features-list .sub-list {
        list-style-type: disc;
        margin-left: 20px;
        font-weight: normal;
        font-size: 20px;
        font-style: italic;
      }

      @media (max-width: 768px) {
        .features-list li {
          font-size: 1.25rem;
        }

        .features-list .sub-list {
          font-size: 1.25rem;
        }
      }

      @media (max-width: 480px) {
        .features-list li {
          font-size: 1rem;
        }

        .features-list .sub-list {
          font-size: 1rem;
        }
    </style>

    <div class="container">
      <h1>Modernize DevOps</h1>
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/re_mapped_pipeline.avif">
      <ul class="features-list">
        <li>Upgrade your software delivery with modern, AI-native tools:</li>
        <ul class="sub-list">
          <li>CI/CD</li>
          <li>Feature Flags</li>
          <li>Infrastructure Management</li>
          <li>Chaos Engineering</li>
        </ul>
      </ul>
    </div>
tabs:
- id: vhkkxyzrj1jt
  title: Harness Platform
  type: browser
  hostname: harness
- id: qxbwotuwpene
  title: Jenkins
  type: website
  url: https://${_SANDBOX_ID}.instruqt.harness-demo.site/
- id: 6in8xullxic9
  title: Shell
  type: terminal
  hostname: sandbox
- id: cx9xtkyemnk3
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: 41tj3oq860o3
  title: Harness Platform
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
- id: rn7jdgn0ii5e
  title: Jenkins
  type: website
  url: https://${_SANDBOX_ID}.instruqt.harness-demo.site/
  new_window: true
difficulty: basic
timelimit: 1600
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Migrate to Harness</h2>
<hr class="cyan">
<br><br>

## Let's get it started!
> - Head back to the **Jenkins Dashboard**
> - Click `Migrate to Harness` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-jenkins-migrator/assets/images/jenkins_harness_migrate_to_harness.png)

> **Select Pipelines for Migration**
> 1) Available Pipelines: `se-lab`
> 1) Convert: `Send to Harness`
> 1) Click **Convert YAML** \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-jenkins-migrator/assets/images/jenkins_harness_migrator.png)

> [!NOTE]
> ***Preview the Pipeline*** <br>
> You can also click `View in browser` to see what the Harness pipeline will look like prior to sending it.

### Success
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-jenkins-migrator/assets/images/jenkins_harness_migration_results.png)
> - Your pipeline should now show up in your **Harness** project!

## Head over to your Harness project
### Select your pipeline

Select **Unified View** from the list \
   ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/module_unified.png)

> 1) Click on **Pipelines** in the left Nav \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/nav_pipelines.png)
> 1) Click on your pipeline created via the Jenkins Migrator

## Update the pipeline
> 1) In the right nav, click on `Codebase` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-jenkins-migrator/assets/images/harness_pipeline_codebase.png)

> **Codebase**
> 1) Select Git Provider: `Third-party Git provider`
> 1) Connector: `workshop-github`
> 1) Repository Name: <pre>`anurag-harness/zuul`</pre>
> 1) Click **Apply Changes** \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-jenkins-migrator/assets/images/harness_configure_codebase.png)

### Click on the `Build` stage
> - On the **Execution** tab \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_tab_execution.png)
> - Take a look at how our the **Jenkins Migrator** translated our Jenkins pipeline to Harness

### Execute your new Pipeline
> Click **Save** in the top right to save your new pipeline. \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_save.png)

> Now click **Run** to execute the pipeline \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_run.png)
> - Docker Connector: `workshop-docker`
> - Click **Apply Selected** \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-devsecops/assets/images/harness_run_pipeline.png)
> Then click **Run Pipeline** \
>   ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-devsecops/assets/images/pipeline_run_pipeline.png)

> [!NOTE]
> How did the execution time compare to what we just saw with Jenkins?

# Congratulations on completing this **Harness workshop**! 🏆
### That's all for now. We hope you enjoyed your hands-on experience with the Harness platform. <br> 📈 We are always looking to improve so please rate your experience and share any suggestions or issues you may have encountered. Thank you!


===============

Click the **Check** button to continue.
