resource "fortios_firewall_address" "firewall_address" {

  for_each = local.firewall_addresses

  name   = each.value.name
  subnet = each.value.subnet
  type   = each.value.type

  dynamic_sort_subtable = true

  lifecycle {
    create_before_destroy = true
  }
}

output "firewall_addresses" {
  value = var.enable_module_output ? fortios_firewall_address.firewall_address[*] : null
}