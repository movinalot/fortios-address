resource "fortios_firewall_policy" "rule1" {

  name            = "rule1"
  action          = "accept"
  logtraffic      = "utm"
  nat             = "disable"
  status          = "enable"
  schedule        = "always"
  inspection_mode = "flow"

  utm_status = "enable"

  dstaddr {
    name = "all"
  }

  dstintf {
    name = "port2"
  }

  service {
    name = "HTTP"
  }

  srcaddr {
    name = "all"
  }

  srcintf {
    name = "port1"
  }
}

resource "fortios_firewall_policy" "rule2" {

  name            = "rule2"
  action          = "accept"
  logtraffic      = "utm"
  nat             = "disable"
  status          = "enable"
  schedule        = "always"
  inspection_mode = "flow"

  utm_status      = "enable"
  av_profile      = "wifi-default"
  ips_sensor      = "protect_email_server"
  ssl_ssh_profile = "certificate-inspection"

  internet_service = "enable"

  internet_service_name {
    name = "Amazon-AWS"
  }

  internet_service_name {
    name = "GitHub-GitHub"
  }

  dstintf {
    name = "port1"
  }

  srcaddr {
    name = "FABRIC_DEVICE"
  }

  srcintf {
    name = "port2"
  }
}

resource "fortios_firewall_policy" "rule3" {

  count = local.web_profile == 1 ? 1 : 0

  name            = "rule3"
  action          = "accept"
  logtraffic      = "utm"
  nat             = "disable"
  status          = "enable"
  schedule        = "always"
  inspection_mode = "flow"

  utm_status      = "enable"
  av_profile      = "wifi-default"
  ips_sensor      = "protect_email_server"
  ssl_ssh_profile = "certificate-inspection"
  webfilter_profile = fortios_webfilter_profile.webfilter_profile[0].name

  internet_service = "enable"

  internet_service_name {
    name = "Amazon-AWS"
  }

  internet_service_name {
    name = "GitHub-GitHub"
  }

  dstintf {
    name = "port1"
  }

  srcaddr {
    name = "FABRIC_DEVICE"
  }

  srcintf {
    name = "port2"
  }


}

output "rule1" {
  value = var.enable_module_output ? fortios_firewall_policy.rule1 : null
}

output "rule2" {
  value = var.enable_module_output ? fortios_firewall_policy.rule2 : null
}

#output "rule3" {
#  value = var.enable_module_output ? fortios_firewall_policy.rule3 : null
#}