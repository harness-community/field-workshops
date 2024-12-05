---
slug: logging-into-your-harness-sandbox-account
id: awihjeuxjehk
type: challenge
title: Logging into your Harness Sandbox Account
teaser: Let's log into Harness using your student credentials!
notes:
- type: text
  contents: |
    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/unscripted.png)<br><br>
    Welcome to the {unscripted} 2024 workshop <br><br>
    **Please wait while we setup your Harness Sandbox environment**
tabs:
- id: bjy336uivvod
  title: Workshop SSO Login
  type: browser
  hostname: harness
- id: w3lpbiyymrly
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
</style><h2 class="cyan">👋 Welcome to your Harness Workshop Sandbox!</h2>
<hr class="cyan">
<br>

> [!IMPORTANT]
> Make sure you scroll to the bottom of the lab guide in each lab
> <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/arrow-turn-down.svg" width="60" height="60" style="vertical-align: right; display: inline; filter: invert(80%) sepia(0%) saturate(0%) hue-rotate(0deg) brightness(90%) contrast(90%);">

<br>

## A Sandbox Account has been provisioned for you to use for the duration of this workshop.
Login to your **Harness Sandbox** account using the details provided below.👇

---
## Harness Sandbox Account details:
|  |   |
| ----- | ----- |
| **Username**    |<pre>`[[ Instruqt-Var key="HARNESS_USER" hostname="sandbox" ]]`</pre>|
| **Password**    |<pre>`[[ Instruqt-Var key="HARNESS_PWD" hostname="sandbox" ]]`</pre>|

> [!NOTE]
> *All credentials for this lab can always be found on the: <br>
>  <img src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/link.svg" alt="Link icon" width="16" height="16" style="display: inline; vertical-align: middle;">`Lab Credentials` tab*


---

> 📝 *Click Single sign-on* <br>
> *Login using the credentials above:* <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/sso_login.png)

===============

Click the **Check** button to continue.
