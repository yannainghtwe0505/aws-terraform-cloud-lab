output "bucket_name" {
  description = "Name of the lab S3 bucket"
  value       = aws_s3_bucket.lab.bucket
}

output "environment" {
  description = "Current environment"
  value       = var.environment
}

output "environment_upper" {
  description = "Environment names converted to uppercase"
  value       = local.environment_upper
}

output "environment_descriptions" {
  description = "Environment descriptions"
  value       = local.environment_descriptions
}

output "application_ports" {
  description = "Application ports above 100"
  value       = local.application_ports
}

output "security_rules" {
  description = "Security rules used in the dynamic block exercise"
  value       = local.security_rules
}

output "application_rule_names" {
  description = "Application rule names"
  value       = local.application_rule_names
}

output "application_rule_map" {
  description = "Application rules converted to a map"
  value       = local.application_rule_map
}

output "dev_instance_size" {
  description = "Instance size for development"
  value       = local.dev_instance_size
}

output "recommended_instance_size" {
  description = "Recommended instance size for the current environment"
  value       = local.recommended_instance_size
}

output "application_port_fallback" {
  description = "Application port with fallback value"
  value       = local.application_port
}

output "final_app_name" {
  description = "Application name with fallback value"
  value       = local.final_app_name
}

output "is_supported_environment" {
  description = "Whether the environment is supported"
  value       = local.is_supported_environment
}

output "environment_status" {
  description = "Environment support status"
  value       = local.environment_status
}

output "selected_instance_size" {
  description = "Instance size selected for the current environment"
  value       = local.selected_instance_size
}

output "aws_region" {
  description = "AWS region used by this environment"
  value       = data.aws_region.current.region
}

output "aws_account_id" {
  description = "AWS account ID used by Terraform"
  value       = data.aws_caller_identity.current.account_id
}

output "available_azs" {
  description = "Availability Zones available in the current region"
  value       = data.aws_availability_zones.available.names
}

output "selected_availability_zones" {
  description = "Availability Zones selected for the environment"
  value       = local.availability_zones
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
  value       = aws_security_group.alb.id
}

output "ec2_security_group_id" {
  description = "Security Group ID for application servers"
  value       = aws_security_group.ec2.id
}

output "rds_security_group_id" {
  description = "Security Group ID for the database"
  value       = aws_security_group.rds.id
}

output "ec2_instance_id" {
  description = "ID of the application EC2 instance"
  value       = aws_instance.app.id
}

output "ec2_private_ip" {
  description = "Private IP address of the application EC2"
  value       = aws_instance.app.private_ip
}

output "ec2_private_dns" {
  description = "Private DNS name of the application EC2"
  value       = aws_instance.app.private_dns
}

output "ssm_endpoint_ids" {
  description = "IDs of the Systems Manager VPC endpoints"
  value = {
    ssm         = aws_vpc_endpoint.ssm.id
    ssmmessages = aws_vpc_endpoint.ssmmessages.id
    ec2messages = aws_vpc_endpoint.ec2messages.id
  }
}

output "vpce_security_group_id" {
  description = "Security Group ID for VPC interface endpoints"
  value       = aws_security_group.vpce.id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.main.id
}

output "nat_eip" {
  description = "Elastic IP address used by the NAT Gateway"
  value       = aws_eip.nat.public_ip
}

output "alb_id" {
  description = "Application Load Balancer ID"
  value       = aws_lb.app.id
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.app.dns_name
}

output "target_group_arn" {
  description = "ARN of the application target group"
  value       = aws_lb_target_group.app.arn
}

output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.postgres.address
}

output "rds_port" {
  description = "RDS PostgreSQL port"
  value       = aws_db_instance.postgres.port
}

output "rds_database_name" {
  description = "Application database name"
  value       = aws_db_instance.postgres.db_name
}

output "database_secret_arn" {
  description = "ARN of the database secret"
  value       = aws_secretsmanager_secret.db.arn
}

output "unique_applications" {
  description = "Unique application names"
  value       = local.unique_applications
}

output "application_list" {
  description = "Application set converted back to a list"
  value       = local.application_list
}

output "final_tags" {
  description = "Merged common and application tags"
  value       = local.final_tags
}

output "all_ports" {
  description = "Combined public and application ports"
  value       = local.all_ports
}

output "all_subnets" {
  description = "Flattened subnet names"
  value       = local.all_subnets
}

output "unique_ports" {
  description = "Ports with duplicates removed"
  value       = local.unique_ports
}

output "sorted_ports" {
  description = "Ports converted to strings and sorted lexicographically"
  value       = local.sorted_ports
}

output "service_names" {
  description = "Service names from the service map"
  value       = local.service_names
}

output "service_port_values" {
  description = "Service port values"
  value       = local.service_port_values
}

output "service_names_upper" {
  description = "Service names converted to uppercase"
  value       = local.service_names_upper
}

output "application_service_ports" {
  description = "Services using application ports"
  value       = local.application_service_ports
}

output "application_config_id" {
  description = "Terraform data resource ID for application configuration"
  value       = terraform_data.application_config.id
}

output "application_deployment_id" {
  description = "Terraform data resource ID for application deployment"
  value       = terraform_data.application_deployment.id
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
