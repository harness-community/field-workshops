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
  type    = string
  default = "default"
}

variable "instruqt_sandbox_id" {
  type = string
}
