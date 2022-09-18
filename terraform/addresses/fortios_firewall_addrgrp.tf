resource "fortios_firewall_addrgrp" "firewall_addrgrp" {

  count = length(local.firewall_addrgrps)

  allow_routing = local.firewall_addrgrps_common.allow_routing
  color         = local.firewall_addrgrps_common.color
  exclude       = local.firewall_addrgrps_common.exclude
  name          = local.firewall_addrgrps[count.index]

  dynamic_sort_subtable = true

  dynamic "member" {
    for_each = [
      for address_group in local.firewall_addresses : address_group
      if address_group.groupname == local.firewall_addrgrps[count.index]
    ]
    content {
      name = fortios_firewall_address.firewall_address[member.value.name].name
    }
  }

}

output "firewall_addrgrps" {
  value = var.enable_module_output ? fortios_firewall_addrgrp.firewall_addrgrp[*] : null
}