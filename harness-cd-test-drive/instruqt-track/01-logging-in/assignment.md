---
slug: logging-in
id: epd6jf4q37o0
type: challenge
title: "\U0001F44B Welcome to Harness"
teaser: Log in to your personal Harness CD sandbox
notes:
- type: text
  contents: "<style>\n  .welcome { display: flex; align-items: center; justify-content:
    center; gap: 56px; min-height: 80vh; padding: 20px; flex-wrap: wrap; }\n  .captain
    { width: 260px; filter: drop-shadow(0 0 28px rgba(0, 173, 228, 0.35)); }\n  .welcome-text
    { max-width: 460px; text-align: left; }\n  .brand { display: flex; align-items:
    center; gap: 10px; font-weight: 700; font-size: 1.2em; }\n  .welcome-text h1 {
    margin: 12px 0 4px; }\n  .tagline { font-style: italic; opacity: 0.8; margin:
    0 0 24px; }\n  .steps { list-style: none; padding: 0; margin: 12px 0 28px; }\n
    \ .steps li { padding: 8px 0; font-size: 1.1em; }\n</style>\n<div class=\"welcome\">\n
    \ <img class=\"captain\" src=\"https://raw.githubusercontent.com/harness-community/field-workshops/main/harness-cd-test-drive/assets/images/captain_canary.png\">\n
    \ <div class=\"welcome-text\">\n    <div class=\"brand\"><img src=\"https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/modules/harness.png\"
    width=\"35\"> harness</div>\n    <h1>Welcome to your CD Test Drive</h1>\n    <p
    class=\"tagline\">The AI-Native Software Delivery Platform</p>\n    <p>In the
    next few minutes, you'll:</p>\n    <ul class=\"steps\">\n      <li>\U0001F50D
    Explore a production-grade deployment pipeline</li>\n      <li>\U0001F680 Deploy
    a real application to Kubernetes</li>\n      <li>\U0001F389 See it running live</li>\n
    \   </ul>\n    <p><strong>Please wait while we set up your sandbox environment...</strong></p>\n
    \ </div>\n</div>"
tabs:
- id: fi9szhknkc1w
  title: Workshop SSO Login
  type: browser
  hostname: harness
- id: njlixgv6uxtu
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: pr4vc2alslzo
  title: Harness Platform
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
difficulty: basic
timelimit: 180
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Welcome to Your Harness CD Test Drive</h2>
<hr class="cyan">
<br>

A sandbox account has been provisioned for you. Log in using the credentials below.

> [!NOTE]
> *If you experience any issues with the embedded browser, click: \
>  <img src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/arrow-up-right-from-square.svg" alt="Arrow icon" width="16" height="16" style="display: inline; vertical-align: middle;">[button label="Harness Platform" variant="success"](tab-2) to open Harness in a new tab*

Harness Account
===
## Your Sandbox Credentials
|  |   |
| ----- | ----- |
| **Username**    |<pre>`[[ Instruqt-Var key="HARNESS_USER" hostname="sandbox" ]]`</pre>|
| **Password**    |<pre>`[[ Instruqt-Var key="HARNESS_PWD" hostname="sandbox" ]]`</pre>|

> [!NOTE]
> *Credentials are always available on the: <br>
>  <img src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/link.svg" alt="Link icon" width="16" height="16" style="display: inline; vertical-align: middle;">[button label="Lab Credentials" variant="success"](tab-1) tab*

---

Signing In
===

> Click **Single sign-on** and log in with the credentials above: <br>
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/sso_login.png)

Project Selection
===

> A **Project** has been created for you. This is your personal sandbox for this test drive. \
> Click on `Select a Project` \
> Click on project `[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]` \
> ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/platform_project_selection.png)

Conclusion
===

Click the **Check** button to continue.
