---
slug: logging-into-your-harness-sandbox-account
id: kdlau7y1zlvg
type: challenge
title: Logging into your Harness Sandbox Account
teaser: Let's log into Harness using your student credentials!
notes:
- type: text
  contents: |
    Welcome to the Harness SE workshop!<br><br>
    **Please wait while we setup your Harness Sandbox environment**
tabs:
- title: Workshop SSO Login
  type: browser
  hostname: harness
- title: Shell
  type: terminal
  hostname: sandbox
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
</style><h2 class="cyan">👋 Welcome to your Harness Workshop Sandbox!</h2>
<hr class="cyan">
<br><br>

A Sandbox Account has been provisioned for you to use for the duration of this workshop.
We take advantage of Just-in-time provisioning for this workshop to automatically provision your user account when you first sign-in to Harness through SAML SSO.<br>
Login to your **Harness Sandbox** account using the details provided below.👇

---
### Harness Sandbox Account details:
*All credentials for this lab can always be found on the: <br>
 `Lab Credentials` tab* <br>

|   |   |
|---|---|
|__User__| ```[[ Instruqt-Var key="HARNESS_USER" hostname="sandbox" ]]``` |
|__Password__| ```[[ Instruqt-Var key="HARNESS_PWD" hostname="sandbox" ]]``` |


---

> 📝 *Click Single sign-on* <br>
> *Login using the credentials above:* <br>
> ![sso_login.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/sso_login.png)

===============

Click the **Check** button to continue.
