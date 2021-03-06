resource "fortios_firewall_address" "firewall_address" {

  for_each = local.firewall_addresses

  name       = each.value.name
  subnet     = each.value.subnet
  type       = each.value.type
  visibility = each.value.visibility
}

output "firewall_addresses" {
  value = var.enable_module_output ? fortios_firewall_address.firewall_address[*] : null
}