---
slug: see-it-live
id: ozqseeel3dwo
type: challenge
title: "\U0001F389 See It Live"
teaser: Meet Captain Canary, running on the Kubernetes cluster you just deployed to
tabs:
- id: 6t0fpw6phz2z
  title: Your App
  type: website
  url: https://${_SANDBOX_ID}.instruqt.harness-demo.site/
- id: tkbsmynrvryb
  title: Harness Platform
  type: browser
  hostname: harness
difficulty: basic
timelimit: 120
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">You Just Shipped Something</h2>
<hr class="cyan">
<br>

Say hi to **Captain Canary**. That's the app you just deployed, running live on a real Google Kubernetes Engine cluster.

The page shows:

- **Version** — the release Harness deployed
- **Pod** — the Kubernetes pod that served your request (you're running two)
- **Uptime** — how long that pod has been up, updated live

> [!NOTE]
> This isn't a simulation. Harness fetched the manifests from GitHub, rolled out the pods, and waited for their health checks to pass before reporting success.

*Tab blank? Open your app in a new browser window: [[ Instruqt-Var key="APP_URL" hostname="sandbox" ]]*

## What You Just Experienced

No scripts. No YAML editing. No `kubectl` commands. Here's what Harness delivered in this test drive:

- **Visual Pipeline Editor** — Build and manage pipelines without scripting
- **Environment Management** — Separate what you deploy from where you deploy it
- **Real-Time Observability** — Full visibility into every deployment step
- **Kubernetes Native** — Rolling, Canary, and Blue-Green out of the box

---

### Ready to see more?

Talk to your Harness account team about:
- **Multi-environment promotion** — Dev to Staging to Prod with approvals
- **Canary and Blue-Green** — Advanced deployment strategies with automatic verification
- **Policy as Code** — OPA-based governance guardrails for every deployment
- **Continuous Verification** — Automatic rollback driven by monitoring data
- **GitOps** — ArgoCD integration for declarative delivery

That's the test drive! Got a few more minutes? Click **Check** for a bonus round with Harness AI.
