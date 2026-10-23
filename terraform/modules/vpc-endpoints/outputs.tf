output "ssm_id" {
  description = "Ssm id"
  value       = aws_vpc_endpoint.ssm.id
}

output "ssmmessages_id" {
  description = "Ssmmessages id"
  value       = aws_vpc_endpoint.ssmmessages.id
}

output "ec2messages_id" {
  description = "Ec2messages id"
  value       = aws_vpc_endpoint.ec2messages.id
}
