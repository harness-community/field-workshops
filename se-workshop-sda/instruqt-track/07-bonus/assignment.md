---
slug: bonus
id: bfjgojxvosiv
type: challenge
title: "\U0001F381 Bonus: Keep Going"
teaser: Ask the agent to explain, audit, and extend what you built
tabs:
- id: svpssywx85s5
  title: Harness
  type: browser
  hostname: harness
- id: ddurlsaj23fh
  title: Your App
  type: service
  hostname: sandbox
  port: 30080
- id: grcsu3zyha4n
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: xprc0k6luhqn
  title: Harness (new window)
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
difficulty: basic
timelimit: 600
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Bonus: Keep Going</h2>
<hr class="cyan">
<br>

You built and shipped a pipeline without opening a pipeline editor. Then you covered the outer
loop: a canary that caught a bad release and rolled it back with no human involved, and a policy
that held every change to the same rules, whoever or whatever wrote it.

The sandbox is yours until the timer runs out. Here are a few things to try.

See the audit trail
===

Go to **Account Settings** → **Security and Governance** → **Audit Trail**, and filter by your
project. Every change the agent made today is there: what changed, when, and on whose behalf. Each change is attributed to **you**, because you
accepted it.

Ask the agent to explain
===

In **Ask AI**, try:

```
Explain what the latest run of the showcase pipeline did, step by step, and how long each stage took.
```

```
Why did the most recent failed run of the showcase pipeline fail, and what stopped the bad release from reaching every pod?
```

Ask the agent to extend
===

```
Write an OPA policy for pipelines that denies any Build and Push step that doesn't use the "har" connector. Don't add it to a policy set yet.
```

```
In the showcase pipeline, add a Run step after "Unit tests" named "Vet" that uses golang:1.27-alpine and runs: go vet ./...
```

Make the app yours, again
===

Switch `flavor` between `ticker` and `billboard` in `showcase.yaml`, bump the version, and ship
it. The approval, the canary, and the health checks all come along for free.

Click **Check** when you're done to finish the workshop. Thanks for building with Harness!
