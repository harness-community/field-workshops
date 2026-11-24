provider "harness" {
  endpoint         = var.harness_endpoint
  account_id       = var.account_id
  platform_api_key = var.api_key
}

locals {
  scope = "${var.account_id}/${var.org_id}/${var.project_id}"
  // The registry's url is authoritative: pkg.harness.io/<account>/<registry> on app.harness.io,
  // a different shape on vanity-domain accounts
  har_prefix = trimprefix(harness_platform_har_registry.showcase.url, "https://")
  har_host   = split("/", local.har_prefix)[0]
}
