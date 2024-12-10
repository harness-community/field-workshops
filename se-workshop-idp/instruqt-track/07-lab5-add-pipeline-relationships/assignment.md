---
slug: lab5-add-pipeline-relationships
id: bldv4hdw2yro
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
        <img src="https://cdn.prod.website-files.com/6222ca42ea87e1bd1aa1d10c/6500c564f73b2108c5825e4c_Harness%20CI-CD%20(1).svg" alt="Harness CI/CD" width="150">
        <p>Harness CI/CD</p>
      </div>
      <div class="plugin-item">
        <img src="https://cdn.prod.website-files.com/6222ca42ea87e1bd1aa1d10c/6500c561a593ecc0b3dd350e_PagerDuty%20(1).svg" alt="PagerDuty" width="150">
        <p>PagerDuty</p>
      </div>
      <div class="plugin-item">
        <img src="https://cdn.prod.website-files.com/6222ca42ea87e1bd1aa1d10c/6500c55df5468e9a8a5f1694_Kubernetes%20(1).svg" alt="Kubernetes" width="150">
        <p>Kubernetes</p>
      </div>
      <div class="plugin-item">
        <img src="https://cdn.prod.website-files.com/6222ca42ea87e1bd1aa1d10c/6500c559c7a841caed716b12_Firehydrant%20(1).svg" alt="Firehydrant" width="150">
        <p>Firehydrant</p>
      </div>
      <div class="plugin-item">
        <img src="https://cdn.prod.website-files.com/6222ca42ea87e1bd1aa1d10c/6500c5565e13f7b9dd969df2_Jira%20(1).svg" alt="Jira" width="150">
        <p>Jira</p>
      </div>
    </div>

    <ul class="features-list">
      <li>Reduce cognitive overload</li>
      <li>Powered by Backstage.io plugins</li>
      <li>Create your own custom Plugins</li>
    </ul>
tabs:
- id: my58bbn4u9zz
  title: Harness Platform
  type: browser
  hostname: harness
- id: ddydxsezn1zc
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: dxfqhp9njpgm
  title: Shell
  type: terminal
  hostname: sandbox
- id: 9clvljyxk0ft
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
      Build and Deploy: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/all/orgs/IDP/projects/Onboarding/pipelines/Onboard_New_App/pipeline-studio?storeType=INLINE
```

> [!IMPORTANT]
> Your YAML must be structured like this \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_component_w_pipeline_yaml.png)

> 1) Click on `Source Control` tab on the left nav \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/vs_code_commit.png)
> 2) Enter your commit message e.g., <pre>`added 'Build and Deploy' pipeline`</pre>
> 3) Click the dropdown `v`
> 4) Click `Commit & Push`
> - Click `Yes` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/vs_code_stage_changes.png)


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
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_component_refresh.png)
> - Click Refresh in the upper right of the `About` section


> [!NOTE]
> It can take up to 30 seconds for the refresh to complete.
> - *What do you expect to see on the CI/CD tab?*


> **Review the CI/CD tab in the catalog service** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_component_cicd.png)
> - You may need to refresh the browser tab
> - Then click on the CI/CD tab in the catalog service
> - From here you will see a sample list of deployments for the associated service


===============

Click the **Check** button to continue.
