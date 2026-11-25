---
slug: ai-bonus
id: zsaji29ygnez
type: challenge
title: "\U0001F916 Bonus: Let AI Build It"
teaser: Switch your pipeline to a canary deployment by asking Harness AI in plain
  English
tabs:
- id: uwtidkfc9xxl
  title: Harness Platform
  type: browser
  hostname: harness
- id: obozbc7la2du
  title: Your App
  type: website
  url: https://${_SANDBOX_ID}.instruqt.harness-demo.site/
difficulty: basic
timelimit: 300
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Bonus: Let AI Build It</h2>
<hr class="cyan">
<br>

Got a few more minutes? Let's have Harness AI rework your pipeline from a plain-English request.

Right now your pipeline uses a **rolling** deployment. You're going to switch it to a **canary** deployment: Harness starts one pod on the new version first, and only rolls out to everything once that pod comes up healthy. If it doesn't, the rollout stops before it touches the rest of your pods.

## Ask Harness AI

> 1) Go to **Pipelines** and click **CD Test Drive** to open Pipeline Studio
> 2) Click **Ask AI** in the lower right corner
> 3) Copy this prompt into the chat:

```
In the CD Test Drive pipeline, change the Deploy Frontend stage from a rolling deployment to a canary deployment: first deploy 1 canary pod, then delete the canary, then do a full rolling deployment. Keep rollback on failure.
```

> 4) Harness AI shows you the change as YAML. Look it over and click **Accept**
> 5) Click **Save** in the top right
> 6) Click the **Deploy Frontend** stage, then the **Execution** tab. You'll see **Canary Deployment → Canary Delete → Rolling Deployment**

> [!NOTE]
> **AI proposes, you decide.** Harness AI shows you every change before it happens, and nothing changes in your pipeline until you accept it.

## Take It for a Spin

> Click **Run**, then **Run Pipeline**, and watch the **Canary Deployment** step bring up a single pod before the full rollout. Your app stays up the whole time — check the **Your App** tab.

## Keep Playing

The sandbox is yours until the timer runs out. A few more prompts to try:

```
Add a manual approval step named "Approve Deploy" at the start of the Deploy Frontend stage. Any project user can approve, including whoever ran the pipeline.
```

```
Explain what the latest execution of the CD Test Drive pipeline did, step by step.
```

Want to see what Harness AI can do across build, deploy, security, and more? Your Harness account team can show you.

Click **Check** when you're done to finish your test drive.
