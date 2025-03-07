---
slug: logging-in
id: 6aesabxjufbl
type: challenge
title: Logging into your Harness Sandbox Account
teaser: Let's log into Harness using your student credentials!
notes:
- type: text
  contents: |-
    <img src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/modules/harness.png" width="35" style="display: inline; vertical-align: middle;"> **harness**<br>
    ***The AI-Native Software Delivery Platform™***

    Today's workshop will provide you with hands-on experience with:<br>

    <img src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/modules/iacm.png" width="40" style="display: inline; vertical-align: middle;"> **Infrastructure as Code Management**
    - One tool for your developers and cloud engineers to collaborate and manage Terraform/OpenTofu Infrastructure-as-Code in a reliable, repeatable way.

    <br>

    **Please wait while we setup your Sandbox environment**
tabs:
- id: 1thsrdhg7dy6
  title: Workshop SSO Login
  type: browser
  hostname: harness
- id: muonoihq9j5y
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: lfrjz9kphr3s
  title: Harness Platform
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
difficulty: basic
timelimit: 1600
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">👋 Welcome to your Harness Workshop Sandbox!</h2>
<hr class="cyan">
<br>

> [!IMPORTANT]
> Make sure you scroll to the bottom of the lab guide in each lab
> <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/arrow-turn-down.svg" width="60" height="60" style="vertical-align: right; display: inline; filter: invert(80%) sepia(0%) saturate(0%) hue-rotate(0deg) brightness(90%) contrast(90%);">

<br>

## A Sandbox Account has been provisioned for you to use for the duration of this workshop.
Login to your **Harness Sandbox** account using the details provided below.👇

> [!IMPORTANT]
> 1) The Instruqt platform this workshop is delivered by uses a browser in browser to simplify the hands-on lab experience.
> 1) Zoom content by clicking in the browser in browser and pressing:
>    1) Mac:`⌘ -`
>    1) PC: `CTRL -`
> 1) *If you experience any issues you can access the Harness Platform in your browser tab by clicking: \
>  <img src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/arrow-up-right-from-square.svg" alt="Arrow icon" width="16" height="16" style="display: inline; vertical-align: middle;">[button label="Harness Platform" variant="success"](tab-2) tab*

Harness Account
===
## Harness Sandbox Account details:
|  |   |
| ----- | ----- |
| **Username**    |<pre>`[[ Instruqt-Var key="HARNESS_USER" hostname="sandbox" ]]`</pre>|
| **Password**    |<pre>`[[ Instruqt-Var key="HARNESS_PWD" hostname="sandbox" ]]`</pre>|

> [!NOTE]
> *All credentials for this lab can always be found on the: <br>
>  <img src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/link.svg" alt="Link icon" width="16" height="16" style="display: inline; vertical-align: middle;">[button label="Lab Credentials" variant="success"](tab-1) tab*

---

Signing In
===

> 📝 *Click Single sign-on* <br>
> *Login using the credentials above:* <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/sso_login.png)

Project Selection
===

> A **Project** has been created for you and is where you will perform the tasks in the subsequent labs. \
> Click on `Select a Project` \
> Click on project `[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]` \
   ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/platform_project_selection.png)


Conclusion
===

Click the **Check** button to continue.
