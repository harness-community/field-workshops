// Define Valid Variables

// Platform
variable "account_id" {
  type = string
}

variable "org_id" {
  type = string
}

variable "project_id" {
  type = string
}

variable "api_key" {
  type      = string
  sensitive = true
}

// Repo
variable "new_repo_id" {
  type = string
}

variable "github_repo_to_clone" {
  type    = string
  default = "nikpapag/harness-cie-workshop"
}

// Workspace
variable "delegate_selector" {
  type    = string
  default = "instruqt-workshop-delegate"
}

variable "namespace" {
  type    = string
  default = "default"
}
