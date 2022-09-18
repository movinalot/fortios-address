output "firewall_addresses_from_CSV" {
  value = var.enable_module_output ? local.firewall_addresses : null
}

output "firewall_addrgrps_from_CSV" {
  value = var.enable_module_output ? local.firewall_addrgrps : null
}