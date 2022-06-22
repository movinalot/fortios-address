terraform {
  required_providers {
    fortios = {
      source = "fortinetdev/fortios"
    }
  }
  required_version = ">= 1.0.0"
}

provider "fortios" {
  hostname = var.fortigate_ip_fqdn
  token    = var.fortigate_api_token
  insecure = "true"
}
