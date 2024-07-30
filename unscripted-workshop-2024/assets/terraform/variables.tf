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
}

// Connector
variable "delegate_selector" {
  type    = string
}

variable "namespace" {
  type    = string
  default = "default"
}

// Harness Variables
variable "instruqt_sandbox_id" {
  type    = string
}
