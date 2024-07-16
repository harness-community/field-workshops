---
slug: lab3-create-a-chaos-experiment
id: nwdknzrac9ri
type: challenge
title: Lab 3 - Create a Chaos Experiment
teaser: Creating your first Chaos Experiment and target an application for fault injection
notes:
- type: text
  contents: |
    In this lab, participants will design their first chaos experiment, selecting targets and defining what actions will be introduced to simulate disruptive events.
tabs:
- title: Harness Platform
  type: browser
  hostname: harness
- title: Boutique App
  type: service
  hostname: sandbox
  path: /
  port: 30001
- title: Grafana
  type: website
  url: https://sandbox-30002-${_SANDBOX_ID}.env.play.instruqt.com/d/edruqxvqvulmoa/boutique-app-dashboard
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
</style><h2 class="cyan">Create a Chaos Experiment</h2>
<hr class="cyan">
<br>

In the left nav, click on: ![ce_nav_experiments.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_nav_experiments.png) <br>
And then click ```+New Experiment``` <br>
![ce_new_experiment.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_new_experiment.png) <br>

## Experiment Overview
- Name: ```cart-delete```
- Chaos Infrastructure Type: ```Kubernetes```
- Select Infrastructure: ```lab-hce```

Then click **Next >** <br>

## Experiment Builder
Select *Continue with blank canvas* <br>
![ce_new_experiment_blank_canvas.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_new_experiment_blank_canvas.png) <br>
And then click ```+Add``` on the canvas <br>
![ce_add_to_canvas.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_add_to_canvas.png) <br>
Navigate to **Kubernetes** faults and select `Pod Delete`
![ce_fault_pod_delete.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_fault_pod_delete.png) <br>

> **pod-delete** <br>
> - **Target Application**
>   - App Namespace: ```[[ Instruqt-Var key="HARNESS_USER_NAME" hostname="sandbox" ]]```
>     - Select ```App Kind```: `deployment`
>   - App Label(s): ```app=cartservice```
> - **Tune Fault**
>   - Chaos Duration: ```60```
> - **Probes**
>   - Click: `+ Select or Add new probes`
>     - Select `frontend-availability-check`
>     - Click `Add to Fault`
>     - Select `OnChaos`
>     - Click `Apply Changes` <br>

Click **Apply Changes**
![ce_experiment_apply_changes.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_experiment_apply_changes.png) <br>

Click **Save** <br>
![ce_save.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_save.png) <br>

If you see this prompt, you can either *Ignore* or *Confirm* <br>
![ce_save_override_image.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_save_override_image.png) <br>
If you select *Confirm* you will need to click **Save** again. <br>

===============

Click the **Check** button to continue.
