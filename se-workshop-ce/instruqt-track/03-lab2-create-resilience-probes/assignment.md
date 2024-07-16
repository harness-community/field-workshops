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
</style><h2 class="cyan">Create Resilience Probes</h2>
<hr class="cyan">
<br>

In the left nav, click on: ![ce_nav_probes.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_nav_probes.png) <br>
And then click ```+New Probe``` <br>
![ce_new_probe.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_new_probe.png) <br>
Select **Kubernetes**  <br>
and probe **HTTP** <br>
![ce_probe_k8s_http.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_probe_k8s_http.png) <br>

> **HTTP Probe**
> - **Overview**
>   - Name: ```frontend-availability-check```
> - **Probe Details**
>   - URL: ```[[ Instruqt-Var key="HARNESS_BOUTIQUE_URL" hostname="sandbox" ]]```
>   - Method: ```GET```
>     - ```Compare Response Code```
>   - Criteria: ```==```
>   - Method: ```200```
> - **Properties**
>   - Timeout: ```10s```
>   - Interval: ```2s```
>   - Attempt: ```5```
>   - Polling Interval: ```2s```

Click **Setup Probe >** <br>

===============

Click the **Check** button to continue.
