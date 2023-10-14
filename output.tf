#---------
# Outputs
#---------
output "sql_server_fqdn" {
  value = module.sql-server.sql_server_fqdn
}

output "sql_server_id" {
  value = module.sql-server.sql_server_id
}

output "sql_server_admin_username" {
  value = module.sql-server.sql_server_admin_username
}

output "sql_server_admin_password" {
  value = module.sql-server.sql_server_admin_password
  sensitive = true
}

output "sql_databases"{
  value = module.sql-server.sql_databases
}