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
- title: Harness Platform
  type: browser
  hostname: harness
- title: Architecture
  type: website
  url: https://htmlpreview.github.io/?https://raw.githubusercontent.com/harness-community/field-workshops/blob/main/se-workshop-ce/assets/misc/diagram.html
- title: Lab Credentials
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
</style><h2 class="cyan">Configuring the Chaos Infrastructure</h2>
<hr class="cyan">
<br><br>

> # Switch to the ```Architecture``` tab to continue

This is the demo app that we will leverage for fault injection in a later lab. Each box represents an individual microservice. <br>
- *What do you think will happen if we target the `cart service` for fault injection?*

<br>

> # Switch to the ```Harness Platform``` tab to continue

First let's select the project that's been created for this workshop <br>
![project_selection.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/project_selection.png)

## Now it's time to start creating some chaos!
![ce_module.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_module.png)

Select the **Chaos Engineering** module from the list <br>

In the left nav, click on: ![ce_nav_environments.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_nav_environments.png) <br>

And then click ```+New Environment``` <br>
![ce_new_environment.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_new_environment.png) <br>


> **New Environment** <br>
> - Name: ```lab```
> - Environment Type: ```Non-Production```

Click ```Create``` <br>

Now click on the environment we just created. <br>
![ce_lab_environment.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_lab_environment.png)

<br><br>
Click ```+Enable Chaos``` <br>
![ce_enable_chaos.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_enable_chaos.png)

>![ce_enable_new_infra.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_enable_new_infra.png)

 - Select ```On new infrastructures``` <br>
Then click **Continue >** <br>

**Workshop Namespace:**
```
[[ Instruqt-Var key="HARNESS_USER_NAME" hostname="sandbox" ]]
```

> **Enable Chaos**
> - **Overview**
>   - Name: ```lab-hce```
> - **Configure**
>   - Installation Type: ```Kubernetes```
>   - Access Type:
>     - Click ***CHANGE***
>     - Select ```Specific namespace access``` ![ce_enable_infra_namespace.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_enable_infra_namespace.png)
>   - Installation Location (Namespace): ```[[ Instruqt-Var key="HARNESS_USER_NAME" hostname="sandbox" ]]```
>   - Service Account Name: ```hce```
> - **Deploy the setup**
>   - You will ***skip*** `Create the namespace` and `Apply the Chaos CRDs` as this is handled for you in this workshop
>     - Click ***Download***

Click **Done** <br><br>

Don't worry about applying the downloaded manifest as we execute the `kubectl apply -f lab-hce-harness-chaos-enable.yml` command for you. <br>

The namespace ***MUST*** be `[[ Instruqt-Var key="HARNESS_USER_NAME" hostname="sandbox" ]]` which is your individual namespace for this workshop <br>

===============

Click the **Check** button to continue.
