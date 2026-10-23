output "application_config_id" {
  description = "Application config id"
  value       = terraform_data.application_config.id
}

output "application_deployment_id" {
  description = "Application deployment id"
  value       = terraform_data.application_deployment.id
}

output "environment_upper" {
  description = "Environment upper"
  value       = local.environment_upper
}

output "environment_descriptions" {
  description = "Environment descriptions"
  value       = local.environment_descriptions
}

output "application_ports" {
  description = "Application ports"
  value       = local.application_ports
}

output "security_rules" {
  description = "Security rules"
  value       = local.security_rules
}

output "application_rule_names" {
  description = "Application rule names"
  value       = local.application_rule_names
}

output "application_rule_map" {
  description = "Application rule map"
  value       = local.application_rule_map
}

output "dev_instance_size" {
  description = "Dev instance size"
  value       = local.dev_instance_size
}

output "recommended_instance_size" {
  description = "Recommended instance size"
  value       = local.recommended_instance_size
}

output "application_port" {
  description = "Application port"
  value       = local.application_port
}

output "final_app_name" {
  description = "Final app name"
  value       = local.final_app_name
}

output "is_supported_environment" {
  description = "Is supported environment"
  value       = local.is_supported_environment
}

output "environment_status" {
  description = "Environment status"
  value       = local.environment_status
}

output "selected_instance_size" {
  description = "Selected instance size"
  value       = local.selected_instance_size
}

output "unique_applications" {
  description = "Unique applications"
  value       = local.unique_applications
}

output "application_list" {
  description = "Application list"
  value       = local.application_list
}

output "final_tags" {
  description = "Final tags"
  value       = local.final_tags
}

output "all_ports" {
  description = "All ports"
  value       = local.all_ports
}

output "all_subnets" {
  description = "All subnets"
  value       = local.all_subnets
}

output "unique_ports" {
  description = "Unique ports"
  value       = local.unique_ports
}

output "sorted_ports" {
  description = "Sorted ports"
  value       = local.sorted_ports
}

output "service_names" {
  description = "Service names"
  value       = local.service_names
}

output "service_port_values" {
  description = "Service port values"
  value       = local.service_port_values
}

output "service_names_upper" {
  description = "Service names upper"
  value       = local.service_names_upper
}

output "application_service_ports" {
  description = "Application service ports"
  value       = local.application_service_ports
}
