output "repo_git_url" {
  value = harness_platform_repo.showcase.git_url
}

output "har_registry_url" {
  value = harness_platform_har_registry.showcase.url
}

output "image_repo" {
  value = "${local.har_prefix}/sda-showcase"
}

output "policy_set_id" {
  value = harness_platform_policyset.guardrails.identifier
}

output "har_host" {
  value = local.har_host
}
