// CD Test Drive — minimal resources
// Creates: GitHub Connector, GHCR Connector, K8s Connector, Dev Environment + Infrastructure, Project Variables

// GitHub Connector (anonymous, for public repos)
resource "harness_platform_connector_github" "github_public" {
  identifier  = "github_public"
  name        = "GitHub Public"
  org_id      = var.org_id
  project_id  = var.project_id
  description = "Anonymous connector for public GitHub repos"
  url         = "https://github.com"
  connection_type = "Account"

  credentials {
    http {
      anonymous {}
    }
  }
}

// GHCR Connector (anonymous, for the public Captain Canary image)
resource "harness_platform_connector_docker" "ghcr_public" {
  identifier         = "ghcr_public"
  name               = "GHCR Public"
  org_id             = var.org_id
  project_id         = var.project_id
  description        = "Anonymous connector for public GitHub Container Registry images"
  type               = "Other"
  url                = "https://ghcr.io"
  delegate_selectors = [var.delegate_selector]
}

// K8s Connector
resource "harness_platform_connector_kubernetes" "instruqt_k8" {
  identifier  = "instruqt_k8"
  name        = "Instruqt K8s"
  org_id      = var.org_id
  project_id  = var.project_id
  description = "Connector to Instruqt workshop K8s cluster"

  inherit_from_delegate {
    delegate_selectors = [var.delegate_selector]
  }
}

// Dev Environment
resource "harness_platform_environment" "dev" {
  identifier = "dev"
  name       = "Dev"
  org_id     = var.org_id
  project_id = var.project_id
  type       = "PreProduction"
}

// Dev Infrastructure
resource "harness_platform_infrastructure" "k8s_dev" {
  identifier      = "k8s_dev"
  name            = "K8s Dev"
  org_id          = var.org_id
  project_id      = var.project_id
  env_id          = harness_platform_environment.dev.identifier
  type            = "KubernetesDirect"
  deployment_type = "Kubernetes"
  yaml            = <<-EOT
    infrastructureDefinition:
      name: "K8s Dev"
      identifier: "k8s_dev"
      description: ""
      tags:
        owner: "${var.project_id}"
      orgIdentifier: "${var.org_id}"
      projectIdentifier: "${var.project_id}"
      environmentRef: "${harness_platform_environment.dev.identifier}"
      deploymentType: Kubernetes
      type: KubernetesDirect
      spec:
        connectorRef: "${harness_platform_connector_kubernetes.instruqt_k8.identifier}"
        namespace: "${var.namespace}"
        releaseName: release-<+INFRA_KEY>
      allowSimultaneousDeployments: true
  EOT
}

// Project Variables
resource "harness_platform_variables" "user_variable" {
  identifier = "username"
  name       = "username"
  org_id     = var.org_id
  project_id = var.project_id
  type       = "String"
  spec {
    value_type  = "FIXED"
    fixed_value = var.project_id
  }
}

resource "harness_platform_variables" "instruqt_variable" {
  identifier = "sandbox_id"
  name       = "sandbox_id"
  org_id     = var.org_id
  project_id = var.project_id
  type       = "String"
  spec {
    value_type  = "FIXED"
    fixed_value = var.instruqt_sandbox_id
  }
}
