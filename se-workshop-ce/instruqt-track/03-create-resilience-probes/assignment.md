---
slug: create-resilience-probes
id: g5vsdqunpxzr
type: challenge
title: Lab 2 - Create Resilience Probes
teaser: Creating Resilience Probes for Chaos Experiment Evaluation
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

      .features-list li {
        margin: 5px 0;
        font-weight: bold;
        font-size: 25px;
      }

      .features-list .sub-list {
        list-style-type: disc;
        margin-left: 20px;
        font-weight: normal;
        font-size: 20px;
        font-style: italic;
      }

      @media (max-width: 768px) {
        .features-list li {
          font-size: 1.25rem;
        }

        .features-list .sub-list {
          font-size: 1.25rem;
        }
      }

      @media (max-width: 480px) {
        .features-list li {
          font-size: 1rem;
        }

        .features-list .sub-list {
          font-size: 1rem;
        }
    </style>

    <div class="container">
      <h1>What is a resilience probe?</h1>
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/ce_resilience_probes.png">
      <ul class="features-list">
        <li>Declarative checks that determine the outcome of a fault:
            <ul class="sub-list">
              <li>Monitors your application's health before, during and after a chaos experiment</li>
              <li>Explore the behavior of a system in a chaotic or unpredictable manner</li>
              <li>Validate the declarative hypothesis set by the user</li>
            </ul>
          </li>
      </ul>
    </div>
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

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-ce/assets/images/ce_nav_probes.png)
> ### Click on **Resilience Probes** in the left Nav
> - Click `+New Probe` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-ce/assets/images/ce_new_probe.png)

> **Select your probe type**
> - Infrastructure Type: `Kubernetes`
> - Chaos probe: `HTTP` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-ce/assets/images/ce_probe_k8s_http.png)

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
>   - Polling Interval: `30s`
>   - Initial Delay: `5s`
> - Click **Create Probe >**

===============

Click the **Check** button to continue.
