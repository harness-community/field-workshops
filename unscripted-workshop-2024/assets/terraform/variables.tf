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
  type = string
}

// K8s Connector
variable "delegate_selector" {
  type = string
}

// Environments
variable "namespace" {
  type    = string
  default = "default"
}

variable "environments" {
  type = map(object({
    env_name         = string
    env_identifier   = string
    env_type         = string
    infra_name       = string
    infra_identifier = string
    serv_name        = string
    serv_identifer   = string
  }))
  default = {
    dev = {
      env_name         = "Dev"
      env_identifier   = "dev"
      env_type         = "PreProduction"
      infra_name       = "K8s Dev"
      infra_identifier = "k8s_dev"
      serv_name        = "backend"
      serv_identifer   = "backend_dev"
    }
    prod = {
      env_name         = "Prod"
      env_identifier   = "prod"
      env_type         = "Production"
      infra_name       = "K8s Prod"
      infra_identifier = "k8s_prod"
      serv_name        = "backend"
      serv_identifer   = "backend_prod"
    }
  }
}

// Harness Variables
variable "instruqt_sandbox_id" {
  type = string
}
