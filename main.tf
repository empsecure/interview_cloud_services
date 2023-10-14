#---------------------------
# Deploy main azure services
#---------------------------
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "random_password" "admin_password" {
  length = 16  # Length required by Azure SQL Server is between 8 and 128
  special = true
  upper = true
  numeric = true
  override_special = "_%@#"
}

module "sql-server" {
  source                   = "./modules/terraform-azure-paas-mssql"
  name                     = "emps-int-we-sqlsvr-01" 
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location 
  admin_user               = "admin-empsecureinterview"
  admin_password           = random_password.admin_password.result 
  #sql_server_version       = ""  # default is 12.0, can override
  firewall_rules = [
    {
      name             = "FirewallRule1"
      start_ip_address = "46.250.214.174" # Given IP range in the assesment
      end_ip_address   = "46.250.214.175"
    },
    {
      name             = "FirewallRule2"
      start_ip_address = chomp(data.http.myip.response_body) # my IP address
      end_ip_address   = chomp(data.http.myip.response_body)
    }
  ]
  mssql_databases = [
    {
      name            = "emps-int-we-sqldb-01"
      sku_name        = "S2"
      collation       = "Latin1_General_100_CI_AS" 
      zone_redundant  = false
      max_size_gb     = 50 
    },
    {
      name            = "emps-int-we-sqldb-02"
      sku_name        = "S2"
      collation       = "Latin1_General_100_CI_AS" 
      zone_redundant  = false
      max_size_gb     = 50 
    }
  ]
  tags                     = local.common_tags
}

