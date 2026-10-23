output "alb_id" {
  description = "Alb id"
  value       = aws_security_group.alb.id
}

output "ec2_id" {
  description = "Ec2 id"
  value       = aws_security_group.ec2.id
}

output "rds_id" {
  description = "Rds id"
  value       = aws_security_group.rds.id
}

output "vpce_id" {
  description = "Vpce id"
  value       = aws_security_group.vpce.id
}
