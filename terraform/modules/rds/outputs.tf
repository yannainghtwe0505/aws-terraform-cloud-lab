output "address" {
  description = "Address"
  value       = aws_db_instance.postgres.address
}

output "port" {
  description = "Port"
  value       = aws_db_instance.postgres.port
}

output "database_name" {
  description = "Database name"
  value       = aws_db_instance.postgres.db_name
}

output "identifier" { value = aws_db_instance.postgres.identifier }
output "multi_az" { value = aws_db_instance.postgres.multi_az }
output "monitoring_interval" { value = aws_db_instance.postgres.monitoring_interval }
