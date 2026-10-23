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

output "vpc_id" { value = module.platform.vpc_id }
output "public_subnet_ids" { value = module.platform.public_subnet_ids }
output "private_subnet_ids" { value = module.platform.private_subnet_ids }
output "autoscaling_group_name" { value = module.platform.autoscaling_group_name }
output "minimum_instances" { value = module.platform.minimum_instances }
output "maximum_instances" { value = module.platform.maximum_instances }
output "database_multi_az" { value = module.platform.database_multi_az }
output "https_enabled" { value = module.platform.https_enabled }
output "alb_dns_name" { value = module.platform.alb_dns_name }
output "database_endpoint" { value = module.platform.database_endpoint }
output "monitoring_level" { value = module.platform.monitoring_level }
output "alarm_names" { value = module.platform.alarm_names }
