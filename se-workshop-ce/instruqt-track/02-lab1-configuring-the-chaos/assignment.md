---
slug: lab1-configuring-the-chaos
id: x8cfeuiglibv
type: challenge
title: Lab 1 - Configuring the Chaos Infrastructure
teaser: Setting up your Harness Chaos Environment
notes:
- type: text
  contents: |
    - Chaos engineering is the continuous process of proactively introducing disruptions to systems to assess and improve their resilience against real-world outages.
    - In this first lab you will setup the Chaos Environment that you will use for fault injection in subsequent labs.

    ![Chaos Engineering](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/chaos-eng-steps.png)
tabs:
- id: ynxtb8ngb9ed
  title: Harness Platform
  type: browser
  hostname: harness
- id: 9h6asoxak7qt
  title: Architecture
  type: website
  url: https://htmlpreview.github.io/?https://raw.githubusercontent.com/harness-community/field-workshops/blob/main/se-workshop-ce/assets/misc/diagram.html
- id: zzjpiaxw4hpv
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
</style><h2 class="cyan">Configuring the Chaos Infrastructure</h2>
<hr class="cyan">
<br><br>

> # Switch to the [button label="Architecture" variant="success"](tab-1) tab to continue

> [!NOTE]
> This is the demo app that we will leverage for fault injection in a later lab. Each box represents an individual microservice.

- *What do you think will happen if we target the `cart service` for fault injection?*

<br>

> # Switch to the [button label="Harness Platform" variant="success"](tab-0) tab to continue




First let's select the project that's been created for this workshop <br>
![project_selection.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/project_selection.png)

## Now it's time to start creating some chaos!
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_module.png)

Select the **Chaos Engineering** module from the list <br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_nav_environments.png)
> ### Click on **Environments** in the left Nav
> - Click `+New Environment` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_new_environment.png)

> **New Environment**
> - Name: <pre>`lab`</pre>
> - Environment Type: `Non-Production`
> - Click **Create**

<br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_lab_environment.png)
> ### Now click on the environment we just created.
> - Select Infrastructure type: `Kubernetes`
> - Click `+New Infrastructure` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_new_infrastructure.png)

> [!IMPORTANT]
> We will NOT be using a Harness Delegate for this Lab.
> - Please Select `No` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_new_infrastructure_v1_or_v2.png)
> - Click **Next >** and configure with the details below ↓

> **New Infrastructure**
> - **Overview**
>   - Name: <pre>`lab-hce`</pre>
>   - Click **Next >**
> - **Configure**
>   - Installation Type: `Kubernetes`
>   - Access Type:
>     - Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pencil.svg" alt="Pencil icon" width="16" height="16" style="display: inline; vertical-align: middle;">***CHANGE***
>     - Select `Specific namespace access` \
>         ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_enable_infra_namespace.png)
>   - Installation Location (Namespace): <pre>`[[ Instruqt-Var key="HARNESS_USER_NAME" hostname="sandbox" ]]`</pre>
>   - Service Account Name: `hce`
>   - Click **Next >**
> - **Deploy the setup**
>   - You will `skip` *Create the namespace* and *Apply the Chaos CRDs* as this is handled for you in this workshop
>   - Click **Download**
> - Click **Done**

> [!IMPORTANT]
> The namespace ***MUST*** be `[[ Instruqt-Var key="HARNESS_USER_NAME" hostname="sandbox" ]]` which is your individual namespace for this workshop

> [!NOTE]
> Don't worry about applying the downloaded manifest as we execute the `kubectl apply -f lab-hce-harness-chaos-enable.yml` command for you

===============

Click the **Check** button to continue.
