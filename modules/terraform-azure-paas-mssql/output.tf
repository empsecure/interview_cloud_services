#---------
# outputs
#----------
output "sql_server_fqdn" {
  value = azurerm_mssql_server.instance.fully_qualified_domain_name
  sensitive = false
}

output "sql_server_id" {
  value = azurerm_mssql_server.instance.id
}

output "sql_server_admin_username" {
  value = azurerm_mssql_server.instance.administrator_login
  sensitive = false
}

output "sql_server_admin_password" {
  value = azurerm_mssql_server.instance.administrator_login_password
  sensitive = true
}

output "sql_databases" {
  value = {for db in azurerm_mssql_database.instances: db.name => db.id}
}
