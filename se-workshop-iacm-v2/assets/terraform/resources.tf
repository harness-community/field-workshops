// Define the resources to create
// Provisions the following into Harness: 
//    Code Repo, Project Variables

// Code Repo
resource "harness_platform_repo" "repo" {
  identifier     = var.new_repo_id
  org_id         = var.org_id
  project_id     = var.project_id
  default_branch = "main"
  source {
    repo = var.github_repo_to_clone
    type = "github"
  }
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
