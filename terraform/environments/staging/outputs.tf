output "environment" {
  description = "Current environment"
  value       = var.environment
}

output "application_name" {
  description = "Application name"
  value       = module.application_config.name
}

output "application_instance_type" {
  description = "Application instance type"
  value       = module.application_config.instance_type
}

output "application_port" {
  description = "Application port"
  value       = module.application_config.port
}

output "application_tags" {
  description = "Application tags"
  value       = module.application_config.tags
}
