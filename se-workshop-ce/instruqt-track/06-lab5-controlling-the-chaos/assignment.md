---
slug: lab5-controlling-the-chaos
id: ymjy7djb6hma
type: challenge
title: Lab 5 - Controlling the Chaos with ChaosGuard
teaser: Using ChaosGuard to enforce controls around who, what, when, and where chaos
  experiments are allowed
notes:
- type: text
  contents: |
    Now let's implement ChaosGuard to restrict execution of chaos experiments.
tabs:
- title: Harness Platform
  type: browser
  hostname: harness
- title: Temp Tab
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
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
</style><h2 class="cyan">Controlling the Chaos with ChaosGuard</h2>
<hr class="cyan">
<br>

In the left nav, click on: ![ce_nav_chaosguard.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_nav_chaosguard.png) <br>
In the upper right, click on: ![ce_chaosguard_conditions.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_chaosguard_conditions.png) <br>
And then click ```+New Condition``` <br>
![ce_new_condition.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_new_condition.png) <br>

## Create New Condition
> - Name: ```block-cartservice-pod-delete```
> - Chaos Infrastructure Type: ```Kubernetes```
>   - Then click **Save**
> - WHAT
>   - FAULT: `pod-delete`
> - WHERE
>   - `*`  *Reference Image Below*
> - WHICH
>   - NAMESPACE: `*`
>   - APP LABEL: `app=cartservice`
> - USING
>   - `*`
> ![ce_chaosguard_select_infra.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_chaosguard_select_infra.png) <br>

Or you can switch to the `YAML` tab and paste this condition.
```
faultSpec:
  operator: EQUAL_TO
  faults:
    - faultType: FAULT
      name: pod-delete
k8sSpec:
  infraSpec:
    operator: EQUAL_TO
    infraIds:
      - "*"
  applicationSpec:
    operator: EQUAL_TO
    workloads:
      - label: app=cartservice
        namespace: "*"
  chaosServiceAccountSpec:
    operator: EQUAL_TO
    serviceAccounts:
      - "*"
```

Click **Save** <br>
![ce_save.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_save.png) <br>

In the upper right, click on: ![ce_chaosguard_rules.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_chaosguard_rules.png) <br>
And then click ```+New Rule``` <br>
![ce_new_rule.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_new_rule.png) <br>


> **Rules**
> - **Overview**
>   - Name: ```block-pod-delete-during-business-hours```
>   - User group(s): *Reference Image Below*
>   - Time window: *Not required to update*
>     - Timezone: ```UTC```
>     - Start Time: ```Current Date/Time```
>     - End Time: ```30m``` from start time
>     - Recurrence: ```Does not repeat```
> - **Add Conditions**
>   - Select `block-cartservice-pod-delete` condition
> ![ce_chaosguard_select_group.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_chaosguard_select_group.png) <br>

Then click **Done >** <br>

> # Instruqt Platform Bug
> ## If you receive an error **422**
> ![ce_chaosguard_error_422.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_chaosguard_error_422.png) <br>
> ## This is due to a bug with the *Instruqt Platform*
> ### Switch to the ```Temp Tab``` tab to continue
> *Login with your credentials found on the: <br>
>  `Lab Credentials` tab* <br>
> Select your `Project` then navigate back to the `Chaos` module and click `ChaosGuard` in the left nav <br>
> Recreate the `Rule` as listed above
> ### Switch to the ```Harness Platform``` tab to continue
> # End of Instruqt Platform Bug


Now click on the `toggle` to enable the rule.
![ce_chaosguard_rule_disabled.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_chaosguard_rule_disabled.png) <br>

In the left nav, click on: ![ce_nav_experiments.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_nav_experiments.png) <br>
And click the play button to run the experiment. <br>
![ce_experiment_play_button.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_experiment_play_button.png) <br>

You will see that the `evaluate-rules` step failed and prevented the experiment from executing. Click on this step to see additional details.
![ce_chaosguard_evaluate_rules.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_chaosguard_evaluate_rules.png) <br>

Head back over to ChaosGuard and disable the rule. Now you are able to execute the experiment again. <br>

# Congratulations on completing this `Harness Chaos Engineering` workshop!
That's all for now. We hope you enjoyed your hands-on experience with the Harness CE module. We are always looking to improve so please rate your experience and share any suggestions or issues you may have encountered. Thank you!

===============

Click the **Check** button to continue.
