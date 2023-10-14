#----------------------------------------------
# Azure PaaS MSSQL Server along with databases
#----------------------------------------------
resource "azurerm_mssql_server" "instance" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.sql_server_version
  administrator_login           = var.admin_user
  administrator_login_password  = var.admin_password
  public_network_access_enabled = var.public_network_access_enabled
  tags = var.tags
  lifecycle {
    ignore_changes = [ 
        tags,
        identity
     ]
  }
}

resource "azurerm_mssql_firewall_rule" "fwrules" {
  for_each = { for i, rule in var.firewall_rules : i => rule }

  name             = each.value.name
  server_id        = azurerm_mssql_server.instance.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}

resource "azurerm_mssql_database" "instances" {
  for_each = { for i, db in var.mssql_databases : i => db }

  name           = each.value.name
  server_id      = azurerm_mssql_server.instance.id
  collation      = each.value.collation
  license_type   = "LicenseIncluded"
  max_size_gb    = each.value.max_size_gb
  read_scale     = false
  sku_name       = each.value.sku_name
  zone_redundant = each.value.zone_redundant

  tags = var.tags
  lifecycle {
    ignore_changes = [ 
        tags
     ]
  }
}