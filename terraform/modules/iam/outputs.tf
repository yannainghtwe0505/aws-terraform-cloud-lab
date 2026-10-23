output "instance_profile_name" {
  description = "Instance profile name"
  value       = aws_iam_instance_profile.ec2.name
}

output "rds_monitoring_role_arn" {
  value      = var.enable_rds_monitoring ? aws_iam_role.rds_monitoring[0].arn : null
  depends_on = [aws_iam_role_policy_attachment.rds_monitoring]
}
