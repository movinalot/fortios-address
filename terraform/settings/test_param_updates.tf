resource "fortios_log_setting" "this" {
  log_policy_comment = "enable"
}

resource "fortios_system_settings" "this" {
  gui_ot                         = "enable"  # Available in 7.2
  #gui_dlp                        = "enable"  # Not in 7.0 will show an update to be made
  #gui_domain_ip_reputation       = "enable"  # Not in 7.0 will show an update to be made
  #gui_dynamic_profile_display    = "enable"  # Not in 7.0 will show an update to be made
  #gui_multiple_utm_profiles      = "disable" # Not in 7.0 will show an update to be made
  #gui_nat46_64                   = "disable" # Not in 7.0 will show an update to be made
  #gui_per_policy_disclaimer      = "enable"  # Not in 7.0 will show an update to be made
}

resource "fortios_system_global" "this" {
  gui_replacement_message_groups = "enable"
}