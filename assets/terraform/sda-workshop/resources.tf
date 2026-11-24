// SDA workshop: what each student's project starts with.
// The student builds the pipeline, Service, Environment and Infrastructure through the
// DevOps Agent; this only creates what the agent needs to point at.

// ---------------------------------------------------------------------------------------
// Harness Code repo. Created empty; setup-sandbox pushes the app into it over git.
// ---------------------------------------------------------------------------------------
resource "harness_platform_repo" "showcase" {
  identifier     = var.repo_id
  org_id         = var.org_id
  project_id     = var.project_id
  default_branch = "main"
  description    = "sda-showcase: the app you ship in this workshop"
  readme         = false
}

// ---------------------------------------------------------------------------------------
// Kubernetes: the student's namespace on the workshop cluster, through their delegate
// ---------------------------------------------------------------------------------------
resource "harness_platform_connector_kubernetes" "workshop_k8s" {
  identifier  = "workshop_k8s"
  name        = "Workshop K8s"
  org_id      = var.org_id
  project_id  = var.project_id
  description = "Your namespace (${var.namespace}) on the workshop cluster"

  inherit_from_delegate {
    delegate_selectors = [var.delegate_selector]
  }
}

// ---------------------------------------------------------------------------------------
// Harness Artifact Registry. Identifiers are account-wide, so it's named for the project.
// ---------------------------------------------------------------------------------------
resource "harness_platform_har_registry" "showcase" {
  identifier   = var.project_id
  description  = "Images built by your pipeline"
  space_ref    = local.scope
  parent_ref   = local.scope
  package_type = "DOCKER"

  config {
    type = "VIRTUAL"
  }
}

// A project-scoped service account token for pushing and pulling images, so the
// workshop's admin PAT never lands in a student-visible secret
resource "harness_platform_service_account" "har" {
  identifier  = "har_robot"
  name        = "HAR robot"
  email       = "har_robot@service.harness.io"
  description = "Pushes and pulls sda-showcase images"
  account_id  = var.account_id
  org_id      = var.org_id
  project_id  = var.project_id
}

resource "harness_platform_role_assignments" "har" {
  org_id                    = var.org_id
  project_id                = var.project_id
  resource_group_identifier = "_all_project_level_resources"
  role_identifier           = "_project_admin"
  principal {
    identifier = harness_platform_service_account.har.identifier
    type       = "SERVICE_ACCOUNT"
  }
}

resource "harness_platform_apikey" "har" {
  identifier  = "har_robot_key"
  name        = "HAR robot key"
  parent_id   = harness_platform_service_account.har.identifier
  apikey_type = "SERVICE_ACCOUNT"
  account_id  = var.account_id
  org_id      = var.org_id
  project_id  = var.project_id
}

resource "harness_platform_token" "har" {
  identifier  = "har_robot_token"
  name        = "HAR robot token"
  parent_id   = harness_platform_service_account.har.identifier
  apikey_id   = harness_platform_apikey.har.identifier
  apikey_type = "SERVICE_ACCOUNT"
  account_id  = var.account_id
  org_id      = var.org_id
  project_id  = var.project_id

  depends_on = [harness_platform_role_assignments.har]
}

resource "harness_platform_secret_text" "har_token" {
  identifier                = "har_token"
  name                      = "har_token"
  description               = "Token for the Harness Artifact Registry"
  org_id                    = var.org_id
  project_id                = var.project_id
  secret_manager_identifier = "harnessSecretManager"
  value_type                = "Inline"
  value                     = harness_platform_token.har.value
}

// Docker connector to HAR, used by CI to push and by the Service to pull
resource "harness_platform_connector_docker" "har" {
  identifier          = "har"
  name                = "Harness Artifact Registry"
  org_id              = var.org_id
  project_id          = var.project_id
  description         = "Your registry: ${local.har_prefix}"
  type                = "Other"
  url                 = "https://${local.har_host}"
  execute_on_delegate = false

  credentials {
    username     = "harness"
    password_ref = harness_platform_secret_text.har_token.identifier
  }
}

// ---------------------------------------------------------------------------------------
// Project variables
// ---------------------------------------------------------------------------------------
resource "harness_platform_variables" "sandbox_id" {
  identifier = "sandbox_id"
  name       = "sandbox_id"
  org_id     = var.org_id
  project_id = var.project_id
  type       = "String"
  spec {
    value_type  = "FIXED"
    fixed_value = lower(var.instruqt_sandbox_id)
  }
}

resource "harness_platform_variables" "image_repo" {
  identifier  = "image_repo"
  name        = "image_repo"
  description = "Where your pipeline pushes the sda-showcase image (no tag)"
  org_id      = var.org_id
  project_id  = var.project_id
  type        = "String"
  spec {
    value_type  = "FIXED"
    fixed_value = "${local.har_prefix}/sda-showcase"
  }
}

// ---------------------------------------------------------------------------------------
// Lab 5 guardrail. Created disabled; the lab's setup script switches the policy set on.
// ---------------------------------------------------------------------------------------
resource "harness_platform_policy" "deploy_needs_approval" {
  identifier  = "deploy_needs_approval"
  name        = "Deploys need an approval"
  description = "Every Deployment stage needs a human approval first"
  org_id      = var.org_id
  project_id  = var.project_id
  rego        = file("${path.module}/policies/deploy_needs_approval.rego")
}

resource "harness_platform_policyset" "guardrails" {
  identifier  = "guardrails"
  name        = "Guardrails"
  description = "Project guardrails, switched on in the Guardrails lab"
  org_id      = var.org_id
  project_id  = var.project_id
  action      = "onrun"
  type        = "pipeline"
  enabled     = false

  policy_references {
    identifier = harness_platform_policy.deploy_needs_approval.identifier
    severity   = "error"
  }
}
