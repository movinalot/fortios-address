variable "fortigate_ip_fqdn" {
  type = string
}

variable "fortigate_api_token" {
  type = string
}

variable "enable_module_output" {
  description = "Enable/Disable module output"
  default     = true
}
