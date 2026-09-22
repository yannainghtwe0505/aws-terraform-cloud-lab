output "bucket_name" {
  description = "Name of the lab S3 bucket"
  value       = aws_s3_bucket.lab.bucket
}

output "environment" {
  description = "Current environment"
  value       = var.environment
}

output "aws_region" {
  description = "AWS region used by this environment"
  value       = var.aws_region
}

output "aws_account_id" {
  description = "AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

output "availability_zones" {
  description = "Availability Zones used by the environment"
  value       = data.aws_availability_zones.available.names
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
