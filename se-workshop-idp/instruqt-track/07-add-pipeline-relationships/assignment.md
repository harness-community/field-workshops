---
slug: add-pipeline-relationships
id: 7u6rb6ahle3q
type: challenge
title: Lab 5 - Add Pipeline Relationships
teaser: Integrate with the tools and providers you use to bring the most useful information
  for developers in the developer portal.
notes:
- type: text
  contents: |-
    <style>
      .plugins-grid {
        display: grid;
        grid-template-columns: repeat(5, 1fr);
        justify-items: center;
        gap: 20px;
        margin: 20px 0;
        text-align: center;
      }

      .plugin-item img {
        max-width: 100%;
        height: auto;
      }

      .plugin-item p {
        margin-top: 10px;
        font-size: 19px;
      }

      .features-list {
        list-style-type: none;
        padding: 0;
      }

      .features-list li {
        margin: 5px 0;
        font-weight: bold;
        font-size: 25px;
      }
    </style>

    <h1>Enhance Your Catalog Items</h1>

    <div class="plugins-grid">
      <div class="plugin-item">
        <img src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/logos/svg/harness_padded.svg" alt="Harness CI/CD" width="150">
        <p>Harness CI/CD</p>
      </div>
      <div class="plugin-item">
        <img src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/logos/svg/pagerduty_padded.svg" alt="PagerDuty" width="150">
        <p>PagerDuty</p>
      </div>
      <div class="plugin-item">
        <img src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/logos/svg/kubernetes_padded.svg" alt="Kubernetes" width="150">
        <p>Kubernetes</p>
      </div>
      <div class="plugin-item">
        <img src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/logos/svg/firehydrant_padded.svg" alt="Firehydrant" width="150">
        <p>Firehydrant</p>
      </div>
      <div class="plugin-item">
        <img src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/logos/svg/jira_software_padded.svg" alt="Jira" width="150">
        <p>Jira</p>
      </div>
    </div>

    <ul class="features-list">
      <li>Reduce cognitive overload</li>
      <li>Powered by Backstage.io plugins</li>
      <li>Create your own custom Plugins</li>
    </ul>
tabs:
- id: ohtdrcpbzq8u
  title: Harness Platform
  type: browser
  hostname: harness
- id: hvrgx2rfursv
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: mwyernm71bkc
  title: Shell
  type: terminal
  hostname: sandbox
- id: gjo7014cgkc2
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
</style><h2 class="cyan">Add Pipeline Relationships</h2>
<hr class="cyan">
<br><br>

> ## Switch to the [button label="Code Editor" variant="success"](tab-1) tab to continue

> **Update `components` **>** `catalog-info.yaml` file**
> - Under `metadata.annotations`
> - Add the YAML data copied from below ↓

```yaml
harness.io/pipelines: |
      Build and Deploy: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/all/orgs/IDP/projects/Onboarding/pipelines/Secure_Build_and_Deploy/executions?storeType=INLINE
```

> [!IMPORTANT]
> Your YAML must be structured like this \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-idp/assets/images/idp_component_w_pipeline_yaml.png)

> 1) Click on `Source Control` tab on the left nav \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/unscripted/vs_code_commit.png)
> 2) Enter your commit message e.g., <pre>`added 'Build and Deploy' pipeline`</pre>
> 3) Click the dropdown `v`
> 4) Click `Commit & Push`
> - Click `Yes` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/unscripted/vs_code_stage_changes.png)


> ## Switch to the [button label="Harness Platform" variant="success"](tab-0) tab to continue

> [!IMPORTANT]
> Committed changes reflect on the catalog in 30 minutes. You can also press the refresh button on the catalog page to instantly sync the system with Git. <br>
> Let's trigger a refresh of the component to see our updates immediately.

## Now we need to refresh our item in the Catalog

> In the left Nav <br>
> - Click on **Catalog**
> - Select your first service
>   - You can use the filter to narrow down the list if needed
>     - Filter: <pre>`[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]`</pre>

> **component — service**
> - Open your service: `[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]-service` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-idp/assets/images/idp_component_refresh.png)
> - Click Refresh in the upper right of the `About` section


> [!NOTE]
> It can take up to 30 seconds for the refresh to complete.
> - *What do you expect to see on the CI/CD tab?*


> **Review the CI/CD tab in the catalog service** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-idp/assets/images/idp_component_cicd.png)
> - You may need to refresh the browser tab
> - Then click on the CI/CD tab in the catalog service
> - From here you will see a sample list of deployments for the associated service


===============

Click the **Check** button to continue.
