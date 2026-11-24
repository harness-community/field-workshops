variable "harness_endpoint" {
  type    = string
  default = "https://app.harness.io/gateway"
}

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

variable "delegate_selector" {
  type = string
}

variable "namespace" {
  type = string
}

variable "instruqt_sandbox_id" {
  type = string
}

variable "repo_id" {
  type    = string
  default = "sda-showcase"
}
