---
slug: explore-pipeline
id: bdutvv9kbrxc
type: challenge
title: "\U0001F50D Explore Your CD Pipeline"
teaser: Take a guided tour of a production-grade deployment pipeline
notes:
- type: text
  contents: |-
    <style>
      .container { display: flex; flex-direction: column; align-items: center; justify-content: center; height: 80vh; text-align: center; padding: 20px; }
      .features-list { list-style: none; padding: 0; text-align: left; max-width: 500px; }
      .features-list li { padding: 8px 0; font-size: 1.1em; }
      .features-list li::before { content: "✅ "; }
    </style>
    <div class="container">
      <h1>Deploy anywhere, no scripting required</h1>
      <img src="https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/modules/cd.png" width="80">
      <br>
      <ul class="features-list">
        <li>Visual and code-based pipeline editor</li>
        <li>Kubernetes, ECS, Lambda, VMs, and more</li>
        <li>Canary, Blue-Green, and Rolling deployments</li>
        <li>Built-in rollback on failure</li>
      </ul>
    </div>
tabs:
- id: egrcra8qg00x
  title: Harness Platform
  type: browser
  hostname: harness
- id: zddgm6pi8nte
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
</style><h2 class="cyan">Explore Your CD Pipeline</h2>
<hr class="cyan">
<br>

A complete deployment pipeline has been pre-built in your sandbox. Let's take a tour.

## Navigate to Pipelines

> 1) In the left sidebar, click **Pipelines**
> 2) Click on the **CD Test Drive** pipeline

> [!NOTE]
> This pipeline was created automatically when your sandbox was provisioned. In practice, teams build these using the visual editor or YAML — both produce the same pipeline definition.


## The Pipeline Studio

> Click the **CD Test Drive** pipeline name to open it, then click **Edit Pipeline** (pencil icon) to see the Pipeline Studio.

> [!NOTE]
> **Visual + YAML — your choice.** Every pipeline can be edited visually or as YAML. Toggle between views anytime using the switch in the top right. Teams that prefer code get code. Teams that prefer visual get visual. Same pipeline, same source of truth.

Notice the pipeline has a single **Deploy Frontend** stage. Click on the stage to see its configuration.


## Service — What You Deploy

> Click on the **Service** tab inside the Deploy Frontend stage.

A **Service** in Harness represents the application you are deploying. This one is configured with:

- **Manifests** — Kubernetes templates pulled straight from a GitHub repository
- **Values** — The container image, replica count, and settings that get rendered into those templates

> [!NOTE]
> Services are **reusable**. Define a service once and deploy it across any number of environments and pipelines. In production you'd also attach an **artifact source** (Docker Hub, ECR, GAR, Artifactory, and more) so Harness tracks every image version and lets you pick one at deploy time.


## Environment — Where You Deploy

> Click on the **Environment** tab.

An **Environment** represents a deployment target — Dev, QA, Staging, Production. Inside it, the **Infrastructure Definition** specifies the Kubernetes cluster and namespace.

You can see:
- **Environment:** `dev`
- **Infrastructure:** `k8s_dev` — a real GKE Kubernetes cluster

> [!NOTE]
> Separating *what you deploy* (Service) from *where you deploy it* (Environment) means the same pipeline can promote across environments without any changes. Dev today, production tomorrow — same pipeline.


## Execution Strategy — How You Deploy

> Click on the **Execution** tab.

This pipeline uses a **Rolling** deployment strategy, which updates pods incrementally with zero downtime.

> [!NOTE]
> Harness supports **Rolling**, **Canary**, and **Blue-Green** strategies out of the box — no scripting required. Each strategy includes automatic **rollback on failure**, so a bad deployment is reversed before it impacts users.

In the next step, you will run this pipeline and watch it deploy to a live Kubernetes cluster.


Click the **Check** button to continue.
