---
slug: create-a-scorecard
id: ddtgss4lwl6b
type: challenge
title: Lab 3 - Create a Scorecard
teaser: Gain confidence by measuring if a service is really gold standard from a DevOps,
  Security and Development maturity view. Of course, you get to define what those
  standards are in your organization.
notes:
- type: text
  contents: |-
    <h1>Scorecards</h1>

    <img src="https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_Scorecards.svg" width="900" style="display: inline; vertical-align: middle;">

    - **Measure software maturity**
    - **Drive migrations and adoption of standards**
    - **Enforce Best Practices**
tabs:
- id: np8y6ccxgycw
  title: Harness Platform
  type: browser
  hostname: harness
- id: xvqxi1sd6vwg
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: akwcfep3cv96
  title: Shell
  type: terminal
  hostname: sandbox
- id: lvssa3u1kltf
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
</style><h2 class="cyan">Create a Scorecard</h2>
<hr class="cyan">
<br><br>

> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_nav_configure.png)
> ### Click on **Configure** in the left Nav
> - Then click on **Scorecards** in the left Nav \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_nav_scorecards.png)
> - And then click `Create New Scorecard` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_create_new_scorecard.png)
> - Configure with the details below ↓

> **Create Scorecard**
> - **Left-Hand Side**
>   - Name: <pre>`[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]`</pre>
>   - Kind: `Component`
>   - Type: `service`
>   - Owners: `TeamA`
>   - Tags: `[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]`
> - **Right-Hand Side**
>   - Click on `+ Add Checks`
>     - Checks: `Select All`
>   - Click on: `Add Selected Checks`
> - Scroll to the bottom
> - Click `Publish Scorecard`

### Now navigate to one of your services

> In the left Nav <br>
> 1) Click on **<- Back to Main Menu**
> 1) Click on **Catalog**
>    1) You can use the filter to narrow down the list if needed
>       - Filter: <pre>`[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]`</pre>
> 1) Select your first service

> [!NOTE]
> - Your scorecard should appear with a grade of 19 (This is NOT good!) \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_component_scorecard.png)

> [!IMPORTANT]
> - If more than one scorecard is present, chances are that someone in this workshop misconfigured their scorecard filters
> - If the sample scorecard is still present, chances are that you misconfigured your scorecard filters

### Click into the scorecard tab to see what checks passed and failed, detailing out your score

## Let's update the grading standards to improve the score

> **Change the criteria** <br>
> - Let’s fix our score the easy way by changing the grading standards
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_nav_configure.png)
> ### Click on **Configure** in the left Nav
> - Then click on **Scorecards** in the left Nav \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_nav_scorecards.png)
> - Find your scorecard: `[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]`
> - Click `Edit`
>   - Toggle **Adjust Weights** on the right hand side \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/idp_scorecard_adjust_weights_toggle.png)
>   - Set the value to `100` for the following checks \
>       *(near the bottom of the list)*:
>     - Spec owner exists
>     - Tech Docs exists
> - Click `Update Scorecard`


> [!NOTE]
> - *How do you expect your services score to change?*


### Now navigate back to one of your services

> In the left Nav <br>
> 1) Click on **<- Back to Main Menu**
> 1) Click on **Catalog**
>    1) You can use the filter to narrow down the list if needed
>       - Filter: <pre>`[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]`</pre>
> 1) Select your first service

### Congratulations on your service's passing grade!

===============

Click the **Check** button to continue.
