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
