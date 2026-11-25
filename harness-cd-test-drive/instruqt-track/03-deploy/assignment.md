---
slug: deploy
id: pgg6trvatxlb
type: challenge
title: "\U0001F680 Deploy to Kubernetes"
teaser: Run the pipeline and watch your application deploy in real time
notes:
- type: text
  contents: |-
    <style>
      .container { display: flex; flex-direction: column; align-items: center; justify-content: center; min-height: 80vh; text-align: center; padding: 20px; }
      .captain { width: 200px; margin: 16px 0 24px; filter: drop-shadow(0 0 28px rgba(0, 173, 228, 0.35)); }
      .features-list { list-style: none; padding: 0; text-align: left; max-width: 500px; }
      .features-list li { padding: 8px 0; font-size: 1.1em; }
      .features-list li::before { content: "✅ "; }
    </style>
    <div class="container">
      <h1>One click to deploy</h1>
      <img class="captain" src="https://raw.githubusercontent.com/harness-community/field-workshops/main/harness-cd-test-drive/assets/images/captain_canary.png">
      <ul class="features-list">
        <li>Real-time execution logs</li>
        <li>Automatic rollback on failure</li>
        <li>Full audit trail of every deployment</li>
        <li>Deploy to any cloud, any cluster</li>
      </ul>
    </div>
tabs:
- id: uecgpphivtbz
  title: Harness Platform
  type: browser
  hostname: harness
- id: qipkrywkp9su
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
difficulty: basic
timelimit: 300
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Deploy to Kubernetes</h2>
<hr class="cyan">
<br>

Time to see it in action. You're going to run the pipeline and deploy the application to a live Kubernetes cluster.

## Run the Pipeline

> 1) Navigate back to **Pipelines** and click on **CD Test Drive**
> 2) Click the **Run** button in the top right
> 3) Click **Run Pipeline**

> [!NOTE]
> In production, pipeline runs are typically triggered automatically — by a Git commit, an API call, a schedule, or another pipeline. Here we're running it manually so you can see the full execution flow.

## Watch the Execution

Your application is now deploying to Kubernetes. Watch it happen in real time.

> 1) Turn on the **Console View** toggle (top right, just above the pipeline graph). It gives the logs the full width of the screen.
> 2) Click any **step** on the left to see its logs
> 3) Watch the **Rollout Deployment** step as Kubernetes starts your pods and waits for them to pass health checks

> [!NOTE]
> **Full visibility into every deployment.** Every log line, every Kubernetes event, every rollback decision — all in one place. No more jumping between `kubectl`, CI logs, and Slack channels to figure out what happened.

## Wait for Success

The deployment takes about a minute. When the green **SUCCESS** badge appears at the top of the page, click **Check**.

Your app will be waiting for you on the next screen. 🎉
