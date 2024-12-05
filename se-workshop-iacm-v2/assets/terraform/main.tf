// Define the provider and any data sources
provider "harness" {
  endpoint         = "https://app.harness.io/gateway"
  account_id       = var.account_id
  platform_api_key = var.api_key
}
