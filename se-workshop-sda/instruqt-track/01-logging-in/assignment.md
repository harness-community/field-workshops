---
slug: logging-in
id: vmt6knmbobts
type: challenge
title: "\U0001F44B Welcome: Log In"
teaser: Log in to your personal Harness project
notes:
- type: text
  contents: "<div style=\"max-width: min(92%, 960px); margin: 3vh auto; text-align:
    left; line-height: 1.5;\">\n  <div style=\"display: flex; align-items: center;
    gap: 10px; font-weight: 700; font-size: 1.2em;\">\n    <img src=\"https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/modules/harness.png\"
    width=\"35\"> harness\n  </div>\n  <h1 style=\"font-size: clamp(1.4em, 3.2vw,
    1.8em); line-height: 1.15; margin: .3em 0 .6em;\">Software Delivery Agent Workshop</h1>\n
    \ <p style=\"margin: 0 0 .4em;\">In the next two hours you'll:</p>\n  <ul style=\"list-style:
    none; padding: 0; margin: 0 0 1em; line-height: 1.7;\">\n    <li>\U0001F3A8 Brand
    your app and ship it through a pull request</li>\n    <li>\U0001F916 Have the
    agent build CI, and fix a failing build with AI</li>\n    <li>\U0001F680 Have
    the agent deploy your app to Kubernetes</li>\n    <li>\U0001F424 Canary a release,
    and watch a bad one roll back</li>\n    <li>\U0001F6E1️ Hit a policy, and have
    the agent fix the pipeline</li>\n  </ul>\n  <p><strong>Your sandbox takes a few
    minutes to set up. Hang tight.</strong></p>\n</div>"
tabs:
- id: bydlzmlnt7k2
  title: Harness
  type: browser
  hostname: harness
- id: uoqlxe7kxx9p
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: kqgx8hax6onm
  title: Harness (new window)
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
difficulty: basic
timelimit: 300
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Welcome</h2>
<hr class="cyan">
<br>

Harness has set up a personal project for you, with an empty Git repo holding your app, an
artifact registry, and your own Kubernetes cluster. Log in with these credentials.

| | |
| ----- | ----- |
| **Username** |<pre>`[[ Instruqt-Var key="HARNESS_USER" hostname="sandbox" ]]`</pre>|
| **Password** |<pre>`[[ Instruqt-Var key="HARNESS_PWD" hostname="sandbox" ]]`</pre>|

> [!NOTE]
> Your credentials are always on the [button label="Lab Credentials" variant="success"](tab-1) tab.
> If the embedded browser misbehaves, open [button label="Harness (new window)" variant="success"](tab-2).
> If it says you're not authorized, you're already signed in to Harness as someone else: copy the
> link into a private/incognito window and sign in there.

Sign in
===

1) In the **Harness** tab, click **Single sign-on** and log in with the credentials above \
   ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/sso_login.png)
2) Click **Select a Project** and pick `[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]` \
   ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/platform_project_selection.png)

Click **Check** to continue.
