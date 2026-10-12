output "name" {
  description = "Application name"
  value       = var.application.name
}

output "port" {
  description = "Application port"
  value       = var.application.port
}

output "instance_type" {
  description = "Application instance type"
  value       = var.application.instance_type
}

output "tags" {
  description = "Final application tags"
  value       = local.final_tags
}

output "summary" {
  description = "Complete application configuration"
  value       = local.application_summary
}
