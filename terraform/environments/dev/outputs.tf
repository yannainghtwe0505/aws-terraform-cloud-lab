output "bucket_name" {
  description = "Name of the lab S3 bucket"
  value       = module.storage.bucket_name
}

output "environment" {
  description = "Current environment"
  value       = var.environment
}

output "environment_upper" {
  description = "Environment names converted to uppercase"
  value       = module.practice.environment_upper
}

output "environment_descriptions" {
  description = "Environment descriptions"
  value       = module.practice.environment_descriptions
}

output "application_ports" {
  description = "Application ports above 100"
  value       = module.practice.application_ports
}

output "security_rules" {
  description = "Security rules used in the dynamic block exercise"
  value       = module.practice.security_rules
}

output "application_rule_names" {
  description = "Application rule names"
  value       = module.practice.application_rule_names
}

output "application_rule_map" {
  description = "Application rules converted to a map"
  value       = module.practice.application_rule_map
}

output "dev_instance_size" {
  description = "Instance size for development"
  value       = module.practice.dev_instance_size
}

output "recommended_instance_size" {
  description = "Recommended instance size for the current environment"
  value       = module.practice.recommended_instance_size
}

output "application_port_fallback" {
  description = "Application port with fallback value"
  value       = module.practice.application_port
}

output "final_app_name" {
  description = "Application name with fallback value"
  value       = module.practice.final_app_name
}

output "is_supported_environment" {
  description = "Whether the environment is supported"
  value       = module.practice.is_supported_environment
}

output "environment_status" {
  description = "Environment support status"
  value       = module.practice.environment_status
}

output "selected_instance_size" {
  description = "Instance size selected for the current environment"
  value       = module.practice.selected_instance_size
}

output "aws_region" {
  description = "AWS region used by this environment"
  value       = module.environment_info.aws_region
}

output "aws_account_id" {
  description = "AWS account ID used by Terraform"
  value       = module.environment_info.aws_account_id
}

output "available_azs" {
  description = "Availability Zones available in the current region"
  value       = module.environment_info.available_azs
}

output "selected_availability_zones" {
  description = "Availability Zones selected for the environment"
  value       = module.environment_info.availability_zones
}

output "vpc_id" {
  description = "ID of the development VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "availability_zones" {
  description = "Availability Zones used by the environment"
  value       = module.vpc.availability_zones
}

output "alb_security_group_id" {
  description = "Security Group ID for the Application Load Balancer"
  value       = module.security_groups.alb_id
}

output "ec2_security_group_id" {
  description = "Security Group ID for application servers"
  value       = module.security_groups.ec2_id
}

output "rds_security_group_id" {
  description = "Security Group ID for the database"
  value       = module.security_groups.rds_id
}

output "ec2_instance_id" {
  description = "ID of the application EC2 instance"
  value       = module.ec2.instance_id
}

output "ec2_private_ip" {
  description = "Private IP address of the application EC2"
  value       = module.ec2.private_ip
}

output "ec2_private_dns" {
  description = "Private DNS name of the application EC2"
  value       = module.ec2.private_dns
}

output "ssm_endpoint_ids" {
  description = "IDs of the Systems Manager VPC endpoints"
  value = {
    ssm         = module.vpc_endpoints.ssm_id
    ssmmessages = module.vpc_endpoints.ssmmessages_id
    ec2messages = module.vpc_endpoints.ec2messages_id
  }
}

output "vpce_security_group_id" {
  description = "Security Group ID for VPC interface endpoints"
  value       = module.security_groups.vpce_id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = module.nat.gateway_id
}

output "nat_eip" {
  description = "Elastic IP address used by the NAT Gateway"
  value       = module.nat.public_ip
}

output "alb_id" {
  description = "Application Load Balancer ID"
  value       = module.alb.id
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.dns_name
}

output "target_group_arn" {
  description = "ARN of the application target group"
  value       = module.alb.target_group_arn
}

output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = module.rds.address
}

output "rds_port" {
  description = "RDS PostgreSQL port"
  value       = module.rds.port
}

output "rds_database_name" {
  description = "Application database name"
  value       = module.rds.database_name
}

output "database_secret_arn" {
  description = "ARN of the database secret"
  value       = module.secrets.arn
}

output "unique_applications" {
  description = "Unique application names"
  value       = module.practice.unique_applications
}

output "application_list" {
  description = "Application set converted back to a list"
  value       = module.practice.application_list
}

output "final_tags" {
  description = "Merged common and application tags"
  value       = module.practice.final_tags
}

output "all_ports" {
  description = "Combined public and application ports"
  value       = module.practice.all_ports
}

output "all_subnets" {
  description = "Flattened subnet names"
  value       = module.practice.all_subnets
}

output "unique_ports" {
  description = "Ports with duplicates removed"
  value       = module.practice.unique_ports
}

output "sorted_ports" {
  description = "Ports converted to strings and sorted lexicographically"
  value       = module.practice.sorted_ports
}

output "service_names" {
  description = "Service names from the service map"
  value       = module.practice.service_names
}

output "service_port_values" {
  description = "Service port values"
  value       = module.practice.service_port_values
}

output "service_names_upper" {
  description = "Service names converted to uppercase"
  value       = module.practice.service_names_upper
}

output "application_service_ports" {
  description = "Services using application ports"
  value       = module.practice.application_service_ports
}

output "application_config_id" {
  description = "Terraform data resource ID for application configuration"
  value       = module.practice.application_config_id
}

output "application_deployment_id" {
  description = "Terraform data resource ID for application deployment"
  value       = module.practice.application_deployment_id
}

output "application_name" {
  description = "Application name from application module"
  value       = module.application_config.name
}

output "application_port" {
  description = "Application port from application module"
  value       = module.application_config.port
}

output "application_instance_type" {
  description = "Application instance type from application module"
  value       = module.application_config.instance_type
}

output "application_tags" {
  description = "Application tags from application module"
  value       = module.application_config.tags
}

output "application_summary" {
  description = "Complete application configuration"
  value       = module.application_config.summary
}

output "monitoring_level" { value = module.monitoring.level }
output "alarm_names" { value = module.monitoring.alarm_names }
output "https_enabled" { value = module.alb.https_enabled }
