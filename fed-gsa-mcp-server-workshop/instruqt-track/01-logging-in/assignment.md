---
slug: logging-in
id: mw98orsssuve
type: challenge
title: 'Step 0: Log in to your lab environment'
teaser: Log into your Harness sandbox with the student credentials provided.
notes:
- type: text
  contents: |
    ## You built an MCP server. Now ship it safely.
    Your lab environment is starting. This takes about 2 minutes.

    **What you will do today**
    1. **Lab 1:** Catch and fix a vulnerable package, then gate the release on an agent evaluation that checks accuracy and expert caveats
    2. **Lab 2:** Add a policy gate so nothing reaches production without approval

    **Before you start:** after you log in, click **Skip** on the three optional challenges. We will build and deploy the pipeline for you so you can go straight to the security work.

    Stuck on any step? Click **Skip** to catch up and keep going.

    *Lab environment provided by Harness.*
tabs:
- id: k6tyorg1oyj2
  title: Workshop SSO Login
  type: browser
  hostname: harness
- id: 9kt0cxcefre9
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: yapsh3psum04
  title: Harness Platform
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
difficulty: ""
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
>  <img src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/arrow-up-right-from-square.svg" alt="Arrow icon" width="16" height="16" style="display: inline; vertical-align: middle;">[button label="Harness Platform" variant="success"](tab-2) tab*

Harness Account
===
## Harness Sandbox Account details:
|  |   |
| ----- | ----- |
| **Username**    |<pre>`[[ Instruqt-Var key="HARNESS_USER" hostname="sandbox" ]]`</pre>|
| **Password**    |<pre>`[[ Instruqt-Var key="HARNESS_PWD" hostname="sandbox" ]]`</pre>|

> [!NOTE]
> *All credentials for this lab can always be found on the: <br>
>  <img src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/link.svg" alt="Link icon" width="16" height="16" style="display: inline; vertical-align: middle;">[button label="Lab Credentials" variant="success"](tab-1) tab*

---

Signing In
===

> 📝 *Click Single sign-on* <br>
> *Login using the credentials above:* <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/sso_login.png)

Project Selection
===

> A **Project** has been created for you and is where you will perform the tasks in the subsequent labs. \
> Click on `Select a Project` \
> Click on project `[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]` \
   ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/platform_project_selection.png)

Conclusion
===

Click the **Check** button to continue.
