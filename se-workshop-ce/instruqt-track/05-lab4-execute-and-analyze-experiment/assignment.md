---
slug: lab4-execute-and-analyze-experiment
id: c6fvq5g4ng7f
type: challenge
title: Lab 4 - Execute and Analyze Experiment Results
teaser: Execute your chaos experiment and use the resilience probes to collect data
notes:
- type: text
  contents: |
    Execute the chaos experiment and use the resilience probes to collect data. Learn how to analyze the results to understand the experiment's impact on your system.
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
</style><h2 class="cyan">Execute and Analyze Experiment Results</h2>
<hr class="cyan">
<br>

> # Switch to the ```Boutique App``` tab to continue

This is our demo app we will use for our Chaos Experiments. <br>
Feel free to *browse* around, *add to cart*, *checkout* and see that everything is working as expected.


> # Switch to the ```Grafana``` tab to continue
*All credentials for this lab can always be found on the: <br>
 `Lab Credentials` tab* <br>

|   |   |
|---|---|
|__User__| ```admin``` |
|__Password__| ```[[ Instruqt-Var key="GRAFANA_PWD" hostname="sandbox" ]]``` |

Let's open the `Boutique App Dashboard` <br>

- Click on: ![ce_grafana_dashboards.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_grafana_dashboards.png)
- Select: ![ce_grafana_boutique_app_dashboard.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_grafana_boutique_app_dashboard.png)
- Minimize the left nav: ![ce_grafana_undock_menu.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_grafana_undock_menu.png)
<br>
We will use this dashboard to get a better understanding of how our chaos experiment impacts the Online Boutique. <br>

> # Switch to the ```Harness Platform``` tab to continue

Time to unleash the chaos! <br>
Click **Run** to get things started <br>
![pipeline_run.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/pipeline_run.png) <br>

This experiment execution will take about 4 minutes to run. <br>

Switch back to the `Grafana` tab and monitor what happens when fault injection begins. <br><br>
Once you see fault injection occuring, you can switch over to the `Boutique App` tab and see first hand how the site is impacted. <br>
- Is this the result you were expecting?
- Why would this behavior be problematic?
<br><br>

> # Switch to the ```Harness Platform``` tab to continue

Let's take a look at the results of our experiment. <br>

> ![ce_experiment_probe_frontend.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_experiment_probe_frontend.png)
> We can see that the frontend availability probe failed, which means that our entire site was unavailable during our fault injection targeted at the cart service. This is likely unexpected and undesired behavior. <br>

The result of these probes, as well as the fault weightage (configured on the `Tune Fault` tab for each fault in the experiment) are used to calculate the experiments `Resililence Score`. <br>
![ce_experiment_result_resilience_score.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_experiment_result_resilience_score_0.png) <br>

===============

Click the **Check** button to continue.
