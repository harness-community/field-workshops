---
slug: lab2b-add-a-dependent-service-component
id: cradh1f80n9q
type: challenge
title: Lab 2b - Add a Service Component
teaser: Configure a service component and associate it with a team, and create a dependency.
notes:
- type: text
  contents: |-
    <h1>Software Catalog - Part 2</h1>

    <img src="https://cdn.prod.website-files.com/6222ca42ea87e1bd1aa1d10c/6502437c71a3b62fff9dff0d_Catalog%20Graph%20(2).svg" width="800" style="display: inline; vertical-align: middle;">

    - **A living software registry**
    - **Establish service ownership with teams**
    - **Track dependencies across services**
tabs:
- id: dmhbpfikdvnt
  title: Harness Platform
  type: browser
  hostname: harness
- id: ljxu0uvxsbcz
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: duxffe4x2enf
  title: Shell
  type: terminal
  hostname: sandbox
- id: yvrpulnn5gyt
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
</style><h2 class="cyan">Add a Dependent Service Component</h2>
<hr class="cyan">
<br><br>

> ## Switch to the [button label="Code Editor" variant="success"](tab-1) tab to continue

> **Update `components` **>** `catalog-info-dependent.yaml` file**
> - Modify the file fields below ↓

> **catalog-info-dependent.yaml**
> - **metadata**
>   - name: <pre>`[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]-service-dependency`</pre>
>   - description: <pre>`My second service`</pre>
>   - tags: <pre>`[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]`</pre>
> - **spec**
>   - owner: <pre>`TeamA`</pre>
>   - dependsOn: <pre>`component:default/[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]-service`</pre>

> 1) Click on `Source Control` tab on the left nav \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/vs_code_commit.png)
> 2) Enter your commit message e.g., <pre>`updated dependent component details`</pre>
> 3) Click the dropdown `v`
> 4) Click `Commit & Push`
> - Click `Yes` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/vs_code_stage_changes.png)

> ## Switch to the [button label="Harness Platform" variant="success"](tab-0) tab to continue

Click on **Register** in the left Nav <br>

> **Register an existing component**
> - Select URL: <pre>`[[ Instruqt-Var key="HARNESS_IDP_REPO_PATH" hostname="sandbox" ]]/components/catalog-info-dependent.yaml`</pre> \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_component_import_url.png)
>   - Click `Analyze`
>   - Click `Import`
> - Click `View Component`


> [!IMPORTANT]
> Your component should look like this \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_component_dependency_overview.png)
> - Take a moment to explore links, source, etc. that were defined in your component and how they are rendered in the UI
>   - Be sure to click on the Dependencies tab


> [!NOTE]
> - *Is this what you expected to see based on the relations we defined?*


===============

Click the **Check** button to continue.
