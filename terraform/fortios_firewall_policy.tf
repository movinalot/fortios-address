resource "fortios_firewall_policy" "rule1" {

  name       = "rule1"
  action     = "accept"
  logtraffic = "utm"
  nat        = "disable"
  status     = "enable"
  schedule   = "always"
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

  name              = "rule2"
  action            = "accept"
  anti_replay       = "enable"
  auth_path         = "disable"
  auto_asic_offload = "enable"
  av_profile        = "wifi-default"
  inspection_mode  = "flow"
  internet_service = "enable"
  ips_sensor        = "protect_email_server"
  logtraffic = "utm"
  schedule   = "always"
  ssl_ssh_profile   = "certificate-inspection"
  status = "enable"
  utm_status        = "enable"

  dstintf {
    name = "port1"
  }

  internet_service_name {
    name = "Amazon-AWS"
  }

  internet_service_name {
    name = "GitHub-GitHub"
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