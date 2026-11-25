---
slug: brand-your-app
id: aeaqnczogz31
type: challenge
title: "\U0001F3A8 Lab 1: Brand Your App"
teaser: Make the app yours, and ship the change through a pull request with an AI-written
  summary
tabs:
- id: ulc0yovtz7vd
  title: Harness
  type: browser
  hostname: harness
- id: sftdvtj5rppt
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: 1xsou5v82ubm
  title: Harness (new window)
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
difficulty: basic
timelimit: 720
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Lab 1: Brand Your App</h2>
<hr class="cyan">
<br>

Your app, **sda-showcase**, lives in a Git repo in **Harness Code**. It comes in two flavors:

| Flavor | What it is |
|---|---|
| `ticker` | A trading-floor board: live FX and crypto quotes, desk clocks, a scrolling tape |
| `billboard` | An LED marquee that scrolls your team's message |

Everything you can change is in one file, `showcase.yaml`. In this lab you change it the way a
team would: on a branch, through a pull request.

Edit showcase.yaml
===

1) In the left navigation, click **Code Repository**, then **sda-showcase**
2) Click `showcase.yaml`, then **Edit**
3) Make it yours. Change at least the `name`. Some ideas:
   - `flavor: billboard` and a `message` for your team
   - your desk's `symbols` (up to 8)
   - a new `accent` color, in quotes, like `"#D7282F"`
   - an `emoji`, by name: `fire`, `tada`, `unicorn`, `chart`, `trophy`... The editor can't type emoji,
     so the app turns the name into one
4) Bump `version` to `1.1.0`

> [!IMPORTANT]
> Keep the quotes around the `accent` color. In YAML, an unquoted `#` starts a comment.

Open a pull request
===

1) Click **Commit changes**
2) Choose **Create a new branch and start a pull request**, and name the branch `brand-my-app`
3) On the pull request form, click the **AI** button in the description box to have AI write
   the summary. Read what it wrote, and edit it if you like
4) Click **Create pull request**
5) Click **Squash and merge**, then **Confirm**

> [!NOTE]
> **Why the AI summary matters:** reviewers get a plain-English description of every change,
> even the ones nobody bothered to describe. It's the first place the agent shows up today, and
> the pattern holds all the way through: it drafts, you review and decide.

Click **Check** when your pull request is merged.
