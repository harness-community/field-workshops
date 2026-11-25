---
slug: execute-and-analyze-experiment
id: jql96kanwcwc
type: challenge
title: Lab 4 - Execute and Analyze Experiment Results
teaser: Execute your chaos experiment and use the resilience probes to collect data
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
      <h1>Analyze experiment</h1>
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/ce_pipelines.png">
      <ul class="features-list">
        <li>Observe the status of fault injection during execution</li>
        <li>Learn what a Resilience Score is and how it is calculated</li>
      </ul>
    </div>
tabs:
- id: fnzevwxm8r8z
  title: Harness Platform
  type: browser
  hostname: harness
- id: p1okvbzrxwvx
  title: Boutique App
  type: service
  hostname: sandbox
  path: /
  port: 30001
- id: dhpbxana3oub
  title: Grafana
  type: website
  url: https://sandbox-30002-${_SANDBOX_ID}.env.play.instruqt.com/d/edruqxvqvulmoa/boutique-app-dashboard
- id: r5lnbxcvlwre
  title: Architecture
  type: website
  url: https://htmlpreview.github.io/?https://raw.githubusercontent.com/harness-community/field-workshops/blob/main/se-workshop-ce/assets/misc/diagram.html
- id: w1hll3poyghd
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
</style><h2 class="cyan">Execute and Analyze Experiment Results</h2>
<hr class="cyan">
<br>

> ## Switch to the [button label="Boutique App" variant="success"](tab-1) tab to continue

> [!NOTE]
> This is our demo app we are targeting for fault injection during our Chaos Experiments.

### Please *browse* around, *add to cart*, *checkout* and verify that everything is working as expected.


> ## Switch to the [button label="Grafana" variant="success"](tab-2) tab to continue
|  |   |
| ----- | ----- |
| **Username**    |<pre>`admin`</pre>|
| **Password**    |<pre>`[[ Instruqt-Var key="GRAFANA_PWD" hostname="sandbox" ]]`</pre>|

> [!NOTE]
> *All credentials for this lab can always be found on the: <br>
>  <img src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/link.svg" alt="Link icon" width="16" height="16" style="display: inline; vertical-align: middle;">[button label="Lab Credentials" variant="success"](tab-4) tab*



> ### Let's open the `Boutique App Dashboard`
> - Click on **Open menu** and select `Dashboards` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-ce/assets/images/ce_grafana_dashboards.png)
> - Select: `Boutique App Dashboard` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-ce/assets/images/ce_grafana_boutique_app_dashboard.png)
> - Click on **Undock menu** to minimize the left nav \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-ce/assets/images/ce_grafana_undock_menu.png)

> [!NOTE]
> We will use this dashboard to get a better understanding of how our chaos experiment impacts the Online Boutique.

> ## Switch to the [button label="Harness Platform" variant="success"](tab-0) tab to continue

## Time to unleash the chaos!
> Click **Run** to execute your experiment. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_run.png)

> [!IMPORTANT]
> This experiment execution will take a few minutes to run. While it's executing switch back to the [button label="Grafana" variant="success"](tab-2) tab and monitor what happens when fault injection begins.

## Once you see fault injection occuring
> - Switch over to the [button label="Boutique App" variant="success"](tab-1) tab and see first hand how the site is impacted
>   - What happens now when you try to *browse* the site?
>   - Is this the result you were expecting?
>   - Why would this behavior be problematic?

> ## Switch to the [button label="Harness Platform" variant="success"](tab-0) tab to continue

## Let's take a look at the results of our experiment
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-ce/assets/images/ce_experiment_probe_frontend.png)
> We can see that the frontend availability probe failed, which means that our entire website was unavailable even though fault injection only targeted the cart service. This is likely unexpected and definitely undesired behavior.

> [!NOTE]
> The result of these *probes*, as well as the fault weightage (configured on the `Tune Fault` tab for each fault in the experiment) are used to calculate the experiments `Resililence Score`. If we add additional *probes* to our fault, and/or additional faults to our experiment the calculation will adjust accordingly.
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-ce/assets/images/ce_experiment_result_resilience_score_0.png)

===============

Click the **Check** button to continue.
