locals {
  csv_data = csvdecode(file("addresses_and_groups.csv"))
  
  firewall_addresses = {for address in local.csv_data : address.name => address}
  firewall_addrgrps = distinct([for j in local.firewall_addresses : j.groupname])

  firewall_addrgrps_common = {
    allow_routing = "enable"
    color         = 0
    exclude       = "disable"
    visibility    = "enable"
  }
}
