---
slug: add-a-service-component
id: heumbhbwmqc0
type: challenge
title: Lab 2a - Add a Service Component
teaser: Configure a service component and associate it with a team, and create a dependency.
notes:
- type: text
  contents: |-
    <h1>Software Catalog</h1>

    <img src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-idp/assets/images/idp_Catalog_Graph.svg" width="800" style="display: inline; vertical-align: middle;">

    - **A living software registry**
    - **Establish service ownership with teams**
    - **Track dependencies across services**
tabs:
- id: jqrniiablcvv
  title: Harness Platform
  type: browser
  hostname: harness
- id: eo7bl2nxfc76
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: rsb4wkkslyih
  title: Shell
  type: terminal
  hostname: sandbox
- id: fwsoys9e77f3
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
</style><h2 class="cyan">Add a Service Component</h2>
<hr class="cyan">
<br><br>

> ## Switch to the [button label="Code Editor" variant="success"](tab-1) tab to continue

> **Update `components` **>** `catalog-info.yaml` file**
> - Modify the file fields below ↓

> **catalog-info.yaml**
> - **metadata**
>   - name: <pre>`[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]-service`</pre>
>   - description: <pre>`My first service`</pre>
>   - tags: <pre>`[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]`</pre>
> - **spec**
>   - owner: <pre>`TeamA`</pre>

> 1) Click on `Source Control` tab on the left nav \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/unscripted/vs_code_commit.png)
> 2) Enter your commit message e.g., <pre>`updated component details`</pre>
> 3) Click the dropdown `v`
> 4) Click `Commit & Push`
> - Click `Yes` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/unscripted/vs_code_stage_changes.png)

> ## Switch to the [button label="Harness Platform" variant="success"](tab-0) tab to continue

## Now it's time to create an IDP Service Component
![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/module_idp.png)

Select the **Internal Developer Portal** module from the list <br>

Click on **Register** in the left Nav <br>

> **Register an existing component**
> - Select URL: <pre>`[[ Instruqt-Var key="HARNESS_IDP_REPO_PATH" hostname="sandbox" ]]/components/catalog-info.yaml`</pre> \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-idp/assets/images/idp_component_import_url.png)
>   - Click `Analyze`
>   - Click `Import`
> - Click `View Component`


> [!IMPORTANT]
> Your component should look like this \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-idp/assets/images/idp_component_overview.png)
> - Take a moment to explore links, source, etc. that were defined in your component and how they are rendered in the UI
>   - Be sure to click on the CI/CD, Scorecard, and API tabs

===============

Click the **Check** button to continue.
