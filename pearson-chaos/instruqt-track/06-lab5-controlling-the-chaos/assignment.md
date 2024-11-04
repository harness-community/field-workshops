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
- id: hrygywaxdh12
  title: Harness Platform
  type: browser
  hostname: harness
- id: ox7h4txqykxu
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
</style><h2 class="cyan">Controlling the Chaos with ChaosGuard</h2>
<hr class="cyan">
<br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_nav_chaosguard.png)
> ### Click on **Chaos Guard** in the left Nav
> - In the upper right click: `Conditions` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_chaosguard_conditions.png)
> - Click `+New Condition` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_new_condition.png)

> **Edit Condition**
> - Name: <pre>`cartservice-pod-delete`</pre>
> - Type: `Kubernetes`
> - Select Chaos Infrastructure Type: `Dedicated Chaos Infrastructure`
> - Click **Save** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_new_condition_k8s_v1.png)

> **Create New Condition**
> - WHAT
>   - FAULT: <pre>`pod-delete`</pre>
> - WHERE
>   - `*` \
>       ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_chaosguard_select_infra.png)
> - WHICH
>   - NAMESPACE: `*`
>   - APP LABEL: <pre>`app=cartservice`</pre>
> - USING
>   - `*`
> - Click **Save** \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_save.png)

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
infraType: Kubernetes
```

> - In the upper right click: `Rules` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_chaosguard_rules.png)
> - Click `+New Rule` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_new_rule.png)

> **Rules**
> - **Overview**
>   - Name: <pre>`block-pod-delete-during-business-hours`</pre>
>   - User group(s): `All Project Users` \
>       ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_chaosguard_select_group.png)
>   - Time window: ***Do Not Update***
>   - Click **Next >**
> - **Add Conditions**
>   - Select `cartservice-pod-delete` condition
> - Click **Done >**
> - Click on the `toggle` to enable the rule \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_chaosguard_rule_enabled.png)

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_nav_experiments.png)
> ### Click on **Chaos Experiments** in the left Nav
> - Click the `play` button on the right to run your experiment \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_experiment_play_button.png)
> You will see that the `evaluate-rules` step failed and prevented the experiment from executing. Click on this step to see additional details.
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_chaosguard_evaluate_rules_failure.png)

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_nav_chaosguard.png)
> ### Click on **Chaos Guard** in the left Nav
> - Click on the `toggle` to disable the rule \
>    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_chaosguard_rule_disabled.png)


> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_nav_experiments.png)
> ### Click on **Chaos Experiments** in the left Nav
> - Click the `play` button on the right to run your experiment \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_experiment_play_button.png)
> You will see that now the `evaluate-rules` step was successful and our experiment is executing.
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-ce/assets/images/ce_chaosguard_evaluate_rules_success.png)

> [!NOTE]
> That is `Policy as Code` in action! Isn't it beautiful?

<br><br>

# Congratulations on completing this **Harness Chaos Engineering**! 🏆
> ### That's all for now. We hope you enjoyed your hands-on experience with the Harness CE module. <br> 📈 We are always looking to improve so please rate your experience and share any suggestions or issues you may have encountered. Thank you!

===============

Click the **Check** button to continue.
