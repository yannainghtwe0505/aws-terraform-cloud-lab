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
