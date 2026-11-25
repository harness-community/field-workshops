# Harness Field Workshops - Powered by Instruqt

![Harness](https://assets-global.website-files.com/6222ca42ea87e1bd1aa1d10c/62242940556df4e8146db519_white-logo.svg)

## Introduction

Hands-on Harness workshops that run in a browser on [Instruqt](https://instruqt.com). Each
participant gets a dedicated Harness project, a login, and any supporting infrastructure the lab
needs (a Kubernetes namespace, a cloud account, a delegate). All of it is created when the lab
starts and removed when it ends.

This repo holds two things:

- The **track source** for every live workshop in the `harness-se` Instruqt organization: lab
  guides (`assignment.md`), lifecycle scripts (setup, check, solve, cleanup) and track
  configuration. This is the source of truth. See [Editing a track](#editing-a-track).
- The **runtime assets** the workshops pull at launch: Terraform, Kubernetes manifests, pipeline
  YAML templates, shared scripts, and the images used in lab guides.

## Workshops

| Workshop | Folder | Audience | Status |
|---|---|---|---|
| DevSecOps | [`se-workshop-devsecops`](se-workshop-devsecops) | CI, CD, STO, OPA, CV | Active, tested nightly |
| Software Delivery Agent | [`se-workshop-sda`](se-workshop-sda) | AI-driven CI/CD, 2-hour intro | Active, tested nightly |
| CD Test Drive | [`harness-cd-test-drive`](harness-cd-test-drive) | 20-minute self-serve CD lab | Active, tested nightly |
| IaCM (AWS, GCP, Azure) | [`se-workshop-iacm`](se-workshop-iacm) | Infrastructure as Code Management | Active, tested nightly; Azure is beta |
| IDP | [`se-workshop-idp`](se-workshop-idp) | Internal Developer Portal | Active, tested nightly (login only) |
| Chaos Engineering | [`se-workshop-ce`](se-workshop-ce) | Chaos experiments and ChaosGuard | Under maintenance, tested nightly |
| Jenkins Migrator | [`se-workshop-jenkins-migrator`](se-workshop-jenkins-migrator) | Migrating Jenkins pipelines to Harness | Active, tested nightly (login only) |
| GSA MCP Server | [`fed-gsa-mcp-server-workshop`](fed-gsa-mcp-server-workshop) | DevSecOps variant built for the GSA event (Nov 2026) | Event track, tested nightly |

"Tested nightly" means an automated `instruqt track test` runs each challenge's setup, solve and
check every night, and alerts the team if anything fails. Where a track's solve scripts are still
stubs, only the steps they automate are tested.

Archived, with no live track: [`ci-cd-devdays`](ci-cd-devdays) (superseded by DevSecOps) and
[`unscripted-workshop-2024`](unscripted-workshop-2024). [`se-workshop-shell`](se-workshop-shell)
is a template for starting a new workshop.

### DevSecOps
1. Building the Application
2. Continuous Deployment - Frontend
3. Continuous Deployment - Backend
4. Security Testing Orchestration
5. Governance via Policy as Code
6. ServiceNow RFC Automation
7. Continuous Verification

### Software Delivery Agent
1. Brand Your App: a pull request with an AI-written summary
2. Build with the Agent: the agent writes the CI pipeline; AI helps fix a failing test
3. Deploy with the Agent: Service, Environment, Infrastructure and a rolling deploy
4. Ship Safely: a canary with health checks and automatic rollback
5. Guardrails: a policy blocks the deploy until the agent adds an approval

### CD Test Drive
1. Explore Your CD Pipeline
2. Deploy to Kubernetes
3. See It Live
4. Bonus: Let AI Build It

### IaCM
1. Clone the IaC Repo
2. Creating a Workspace
3. Create an IaCM Pipeline
4. Security Testing Orchestration
5. Drift Detection
6. Governance
7. Cost Estimation and State Changes
8. Pull Request Automation

Each attendee gets their own AWS account, GCP project or Azure subscription.

### IDP
1. Clone the IDP Repo
2. Add a Service Component (and a dependent component)
3. Create a Scorecard
4. Create a Self-Service Workflow
5. Add Pipeline Relationships
6. Cloud Development Environments

### Chaos Engineering
1. Configuring the Chaos Infrastructure
2. Create Resilience Probes
3. Create a Chaos Experiment
4. Execute and Analyze Experiment Results
5. Controlling the Chaos with ChaosGuard

### Jenkins Migrator
1. Create a Jenkins Pipeline
2. Migrate to Harness

## Repo layout

- `assets/`: shared across workshops: Terraform (`assets/terraform/<workshop>`), Kubernetes
  manifests (including the delegate template), shared scripts, and common lab images
- `<workshop>/assets/`: assets for one workshop, such as YAML templates and lab guide images
- `<workshop>/instruqt-track/`: the Instruqt track (IaCM has one per cloud under
  `se-workshop-iacm/instruqt-tracks/`)

## Editing a track

Each track folder maps to one Instruqt track in the `harness-se` organization:

| Instruqt track | Folder |
|---|---|
| `se-workshop-devsecops` | `se-workshop-devsecops/instruqt-track` |
| `se-workshop-sda` | `se-workshop-sda/instruqt-track` |
| `harness-cd-test-drive` | `harness-cd-test-drive/instruqt-track` |
| `se-workshop-iacm-aws-1-2-aws` | `se-workshop-iacm/instruqt-tracks/aws` |
| `se-workshop-iacm-aws-1-1` | `se-workshop-iacm/instruqt-tracks/aws-1-1` |
| `se-workshop-iacm-gcp` | `se-workshop-iacm/instruqt-tracks/gcp` |
| `se-workshop-iacm-azure` | `se-workshop-iacm/instruqt-tracks/azure` |
| `se-workshop-idp` | `se-workshop-idp/instruqt-track` |
| `se-workshop-ce` | `se-workshop-ce/instruqt-track` |
| `se-workshop-jenkins-migrator` | `se-workshop-jenkins-migrator/instruqt-track` |
| `fed-gsa-mcp-server-workshop` | `fed-gsa-mcp-server-workshop/instruqt-track` |
| `se-workshop-shell` (template) | `se-workshop-shell/instruqt-track` |

To change a track:

1. Edit it here, on a branch.
2. From the track folder, run `instruqt track validate`, then `instruqt track push`.
3. Run `instruqt track test --skip-fail-check harness-se/<track>`.
4. Open a pull request.

If you change a track in the Instruqt web editor instead, run `instruqt track pull` in its folder
afterwards and commit the result, so this repo doesn't fall behind.

Never put secrets in a track. This repo is public. Use Instruqt team secrets (listed in each
track's `config.yml`) and read them from the environment.

## Branches

Workshops clone **`main`** when a lab starts, so a merge to `main` reaches every new session right
away. Many lab guide images are still linked from the **`harness-se`** branch, and the IaCM lab
images from **`iacm-updates`**. Don't delete either branch, or move files on them, until those
links point at `main`.

## Contributing

Pull requests and issues are welcome. Because `main` is live, test a change before merging it:
run `instruqt track test --skip-fail-check <track>` against the workshops it affects.

## Contact

The Harness Solutions Engineering team maintains these workshops. Open an issue in this repo for
bugs or questions.
