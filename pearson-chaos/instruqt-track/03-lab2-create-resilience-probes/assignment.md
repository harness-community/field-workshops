---
slug: lab2-create-resilience-probes
id: g5vsdqunpxzr
type: challenge
title: Lab 2 - Create Resilience Probes
teaser: Creating Resilience Probes for Chaos Experiment Evaluation
notes:
- type: text
  contents: |
    <br>In this first lab you will learn how to create resilience probes to automate the evaluation of your experiment hypothesis. This is crucial for understanding the impact of faults injected during chaos experiments.
tabs:
- id: rexhcvpkslzm
  title: Harness Platform
  type: browser
  hostname: harness
- id: yhdz0gxtv2yl
  title: Architecture
  type: website
  url: https://htmlpreview.github.io/?https://raw.githubusercontent.com/harness-community/field-workshops/blob/main/se-workshop-ce/assets/misc/diagram.html
- id: blmi1uerkhzl
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
</style><h2 class="cyan">Create Resilience Probes</h2>
<hr class="cyan">
<br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_nav_probes.png)
> ### Click on **Resilience Probes** in the left Nav
> - Click `+New Probe` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_new_probe.png)

> **Select your probe type**
> - Infrastructure Type: `Kubernetes`
> - Chaos probe: `HTTP` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_probe_k8s_http.png)

> **HTTP Probe**
> - **Overview**
>   - Name: <pre>`frontend-availability-check`</pre>
>   - Click **Configure Details >**
> - **Probe Details**
>   - URL: <pre>`[[ Instruqt-Var key="HARNESS_BOUTIQUE_URL" hostname="sandbox" ]]`</pre>
>   - Method: `GET`
>     - `Compare Response Code`
>   - Criteria: `==`
>   - Response Code: `200`
>   - Click **Configure Properties >**
> - **Properties**
>   - Timeout: `10s`
>   - Interval: `2s`
>   - Attempt: `5`
> - Click **Setup Probe >**

===============

Click the **Check** button to continue.
