locals {
  web_profile = 0
}
resource "fortios_webfilter_profile" "webfilter_profile" {

  count = local.web_profile == 1 ? 1 : 0

  extended_log                  = "disable"
  https_replacemsg              = "enable"
  inspection_mode               = "flow-based"
  log_all_url                   = "disable"
  name                          = "GLOBAL"
  post_action                   = "normal"
  web_content_log               = "enable"
  web_extended_all_action_log   = "disable"
  web_filter_activex_log        = "enable"
  web_filter_applet_log         = "enable"
  web_filter_command_block_log  = "enable"
  web_filter_cookie_log         = "enable"
  web_filter_cookie_removal_log = "enable"
  web_filter_js_log             = "enable"
  web_filter_jscript_log        = "enable"
  web_filter_referer_log        = "enable"
  web_filter_unknown_log        = "enable"
  web_filter_vbs_log            = "enable"
  web_ftgd_err_log              = "enable"
  web_ftgd_quota_usage          = "enable"
  web_invalid_domain_log        = "enable"
  web_url_log                   = "enable"
  wisp                          = "disable"
  wisp_algorithm                = "auto-learning"
  youtube_channel_status        = "disable"

  ftgd_wf {
    exempt_quota         = "17"
    max_quota_timeout    = 300
    rate_crl_urls        = "enable"
    rate_css_urls        = "enable"
    rate_image_urls      = "enable"
    rate_javascript_urls = "enable"

    filters {
      action                = "warning"
      category              = 2
      id                    = 1
      log                   = "enable"
      warn_duration         = "5m"
      warning_duration_type = "timeout"
      warning_prompt        = "per-category"
    }
    filters {
      action                = "warning"
      category              = 7
      id                    = 2
      log                   = "enable"
      warn_duration         = "5m"
      warning_duration_type = "timeout"
      warning_prompt        = "per-category"
    }
  }

  override {
    ovrd_cookie       = "deny"
    ovrd_dur          = "15m"
    ovrd_dur_mode     = "constant"
    ovrd_scope        = "user"
    profile_attribute = "Login-LAT-Service"
    profile_type      = "list"
  }

  web {
    blacklist           = "disable"
    bword_table         = 0
    bword_threshold     = 10
    content_header_list = 0
    log_search          = "disable"
    urlfilter_table     = 0
    youtube_restrict    = "none"
  }

}

/*resource "fortios_webfilter_profile" "webfilter_profile_80" {

  extended_log                  = "disable"
  https_replacemsg              = "disable" #changed from enable
  inspection_mode               = "flow-based"
  log_all_url                   = "disable"
  name                          = "GLOBAL 80"
  post_action                   = "normal"
  web_content_log               = "enable"
  web_extended_all_action_log   = "disable"
  web_filter_activex_log        = "enable"
  web_filter_applet_log         = "enable"
  web_filter_command_block_log  = "enable"
  web_filter_cookie_log         = "enable"
  web_filter_cookie_removal_log = "enable"
  web_filter_js_log             = "enable"
  web_filter_jscript_log        = "enable"
  web_filter_referer_log        = "enable"
  web_filter_unknown_log        = "enable"
  web_filter_vbs_log            = "enable"
  web_ftgd_err_log              = "enable"
  web_ftgd_quota_usage          = "enable"
  web_invalid_domain_log        = "enable"
  web_url_log                   = "enable"
  wisp                          = "disable"
  wisp_algorithm                = "auto-learning"
  youtube_channel_status        = "disable"

  ftgd_wf {
    exempt_quota         = "17"
    max_quota_timeout    = 300
    rate_crl_urls        = "enable"
    rate_css_urls        = "enable"
    rate_image_urls      = "enable"
    rate_javascript_urls = "enable"

    filters {
      action                = "warning"
      category              = 2
      id                    = 1
      log                   = "enable"
      warn_duration         = "5m"
      warning_duration_type = "timeout"
      warning_prompt        = "per-category"
    }
    filters {
      action                = "warning"
      category              = 7
      id                    = 2
      log                   = "enable"
      warn_duration         = "5m"
      warning_duration_type = "timeout"
      warning_prompt        = "per-category"
    }
  }

  override {
    ovrd_cookie       = "deny"
    ovrd_dur          = "15m"
    ovrd_dur_mode     = "constant"
    ovrd_scope        = "user"
    profile_attribute = "Login-LAT-Service"
    profile_type      = "list"
  }

  web {
    blacklist           = "disable"
    bword_table         = 0
    bword_threshold     = 10
    content_header_list = 0
    log_search          = "disable"
    urlfilter_table     = 0
    youtube_restrict    = "none"
  }

}*/