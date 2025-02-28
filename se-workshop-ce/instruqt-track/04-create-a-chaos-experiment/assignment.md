---
slug: create-a-chaos-experiment
id: nwdknzrac9ri
type: challenge
title: Lab 3 - Create a Chaos Experiment
teaser: Creating your first Chaos Experiment and target an application for fault injection
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

      .harness-image {
        max-width: 90%;
        max-height: 65%;
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

      @media (max-width: 768px) {
        .features-list li {
          font-size: 1.25rem;
        }
      }

      @media (max-width: 480px) {
        .features-list li {
          font-size: 1rem;
        }
    </style>

    <div class="container">
      <h1>Industry’s  widest coverage on Chaos Faults™</h1>
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/ce_experiment_coverage.png">
      <ul class="features-list">
        <li>Boost your organization's chaos engineering effectiveness with our ChaosHub.</li>
        <li>Featuring a wide range of curated, pre-built chaos scenarios, it's designed for easy implementation and maximum resilience.</li>
      </ul>
    </div>
tabs:
- id: vjcae98tyu8q
  title: Harness Platform
  type: browser
  hostname: harness
- id: svlgiydwxl7d
  title: Boutique App
  type: service
  hostname: sandbox
  path: /
  port: 30001
- id: lx7sus9u8o6p
  title: Grafana
  type: website
  url: https://sandbox-30002-${_SANDBOX_ID}.env.play.instruqt.com/d/edruqxvqvulmoa/boutique-app-dashboard
- id: pt6a1owotvzo
  title: Architecture
  type: website
  url: https://htmlpreview.github.io/?https://raw.githubusercontent.com/harness-community/field-workshops/blob/main/se-workshop-ce/assets/misc/diagram.html
- id: gurdaotbrhqt
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
</style><h2 class="cyan">Create a Chaos Experiment</h2>
<hr class="cyan">
<br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_nav_experiments.png)
> ### Click on **Chaos Experiments** in the left Nav
> - Click `+New Experiment` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_new_experiment.png)

> **Experiment Overview**
> - Name: <pre>`cart-delete`</pre>
> - Chaos Infrastructure Type: `Kubernetes` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_k8s_v1_infrastructure.png)
> - Select Infrastructure: `lab-hce`
>   - Click **Apply**
> - Click **Next >**

> **Experiment Builder**
> - Select `Start with blank canvas` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_new_experiment_blank_canvas.png)
> - Click `+Add` on the canvas \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_add_to_canvas.png)
> - Navigate to **Kubernetes** faults and select `Pod Delete` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_fault_pod_delete.png)
> - Configure with the details below ↓

> **pod-delete**
> - **Target Application**
>   - App Namespace: `[[ Instruqt-Var key="HARNESS_USER_NAME" hostname="sandbox" ]]`
>     - Select `App Kind`: `deployment`
>   - App Label(s): `app=cartservice`
> - **Tune Fault**
>   - Chaos Duration: `60`
> - **Probes**
>   - Click: `+ Select or Add new probes`
>     - Select `frontend-availability-check`
>     - Click `Add to Fault`
>     - Select `OnChaos`
>     - Click `Apply Changes`
> - Click **Apply Changes** \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_experiment_apply_changes.png)

### Save your Experiment
> Click **Save** in the top right to save your experiment. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_save.png)

> [!NOTE]
> Don't **Run** your experiment yet. We will get to that in the next lab!

===============

Click the **Check** button to continue.
