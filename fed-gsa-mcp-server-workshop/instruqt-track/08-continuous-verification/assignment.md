---
slug: continuous-verification
id: fmecshoyerye
type: challenge
title: 'Bonus: Verify after deploy'
teaser: Optional, after the session. Watch a deployment with continuous verification
  and roll back automatically if it misbehaves.
notes:
- type: text
  contents: |
    ## Bonus: Verify after deploy
    Optional, after the session. See how a deployment can be watched after release and rolled back automatically if it misbehaves.
tabs:
- id: d1tvcpfbikal
  title: Harness Platform
  type: browser
  hostname: harness
- id: msjptr5udmbv
  title: Demo App
  type: website
  url: https://${_SANDBOX_ID}.instruqt.harness-demo.site/
- id: dn4buxenl1bh
  title: ServiceNow
  type: browser
  hostname: servicenow
- id: qaefwufsxgfg
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: 6ywnode2kfhj
  title: Shell
  type: terminal
  hostname: sandbox
- id: ddgzxmpd6xv5
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
difficulty: ""
timelimit: 1600
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Continuous Verification</h2>
<hr class="cyan">
<br><br>

## Now let's add Continuous Verification
> Go back to the **Harness** `Pipeline Studio` by clicking the **Edit Pipeline** button \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_edit.png)
> 1) In the right nav, click on `Advanced Options` \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_advanced_options.png)
>    1) Under **Stage Execution Settings** click the radio button next to `Yes` \
>       ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_allow_stage_execution.png)
>     *This will allow us to execute an individual **Stage** of our pipeline*
>    1) Click **Apply Changes** in the top right
> 1) Hover over the ***Approval*** stage and click the **X** to delete it \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-devsecops/assets/images/pipeline_delete_approval_stage.png)
> 1) Click on the ***Backend - Deployment*** stage
> 1) Click on the **Environment** tab \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_tab_environment.png)
>    1) Click on the radio button next to \
>     `Deploy to Different Environment`
>    1) Specify Environment: `Dev`
>    1) Specify Infrastructure: `K8s Dev`
>    1) Click **Continue >**
> 1) On the **Execution** tab \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_tab_execution.png)
>    1) `Between` the ***Canary Deployment*** and the ***Canary Delete*** steps
>    1) Click on the `+` icon to add a new step \
>       ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/unscripted/unscripted_pipeline_deploy_canary_add_step.png)
>    1) Select `Add Step`
>    1) Select `Verify` from the Step Library \
>       ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_step_verify.png)
>    1) Configure with the details below ↓

> **Verify**
> - Name: <pre>`Verify`</pre>
> - Continuous Verification Type: `Canary`
> - Sensitivity: `Low`
> - Duration: `5mins`
> - Click **Apply Changes** in the top right

> [!NOTE]
> ***Continuous Verification Sensitivity*** <br>
> This is to define how sensitive the ML algorithms are going to be on deviation from the baseline.

Execute your Pipeline
===
> Click **Save** in the top right to save your pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_save.png)

> Now click **Run** to execute the pipeline. <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/pipeline_run.png)<br>
> - Click the **All Stages** dropdown
> - Select only the `Backend - Deployment` stage \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/se-workshop-devsecops/assets/images/pipeline_stage_execute_backend.png)
> - Then Click **Run Pipeline**

> [!NOTE]
> It may take a minute or two for ***Continuous Verification*** to start.

Visualize the Canary Deployment
===
### While the canary deployment is ongoing see if you can spot the canary!
> #### Switch to the [button label="Demo App" variant="success"](tab-1) tab to continue
> - Click the `Check Release` button \
>  *(Don't worry! Keep on clicking it!)* \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/unscripted/unscripted_captain_canary.png)

<br>

### Distribution Test
> - Now click on the `Start` button on the **Distribution Test** panel
> - Then click the **Play** `▶️` button to observe the traffic distribution \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/unscripted/unscripted_traffic_distribution_test.png)

<br>

### Validate the outcome of the verification on the pipeline execution details
> #### Switch to the [button label="Harness Platform" variant="success"](tab-0) tab to continue
> 1) Toggle `Console View`
> 2) Select the `Verify` step
> 3) Uncheck the option to `Display only anomalous metrics and affected nodes`
> 4) Click the `⏷` to view the details
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/unscripted/unscripted_cv_verification.png)

> [!NOTE]
**This is just the beginning**<br>
> - `Harness Continuous Verification` integrates with APMs and logging tools to verify that the deployment is running safely and efficiently.
> - Harness CV applies **machine learning** algorithms to every deployment for identifying normal behavior.
> - This allows Harness to identify and flag anomalies in future deployments.
> - During the Verify step, Harness CV `automatically` triggers a **rollback** if anomalies are found.

Conclusion
===
# Congratulations on completing this **Harness workshop**! 🏆
### That's all for now. We hope you enjoyed your hands-on experience with the Harness platform. <br> 📈 We are always looking to improve so please rate your experience and share any suggestions or issues you may have encountered. Thank you!

===============

Click the **Check** button to continue.
