#-----------------
# module variables
#-----------------
variable resource_group_name {
  type = string
  description = "resource group to deploy Azure mssql server."
}

variable "location" {
  type        = string
  description = "Azure region to deploy Azure mssql server."
}

variable "name" {
  type = string
  description = "Name of the Azure mssql server."
}

variable "sql_server_version" {
  type = string
  description = "Version of the Azure mssql server."
  default = "12.0"
}

variable "admin_user" {
  type = string
  description = "Admin username for the mssql server."
  default = "admin-empsecureinterview"
}

variable "admin_password" {
  type = string
  description = "Admin password for the mssql server."
}

variable "public_network_access_enabled" {
  type = bool
  description = "Whether to enable public network or not"
  default = true
}

variable "firewall_rules" {
  description = "List of firewall rules"
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
}

variable "mssql_databases" {
  description = "List of mssql databases"
  type = list(object({
    name             = string
    collation        = string
    max_size_gb      = number
    sku_name         = string
    zone_redundant   = bool
  }))
}

variable "tags" {}
