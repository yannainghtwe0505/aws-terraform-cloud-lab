output "id" {
  description = "Id"
  value       = aws_lb.app.id
}

output "dns_name" {
  description = "Dns name"
  value       = aws_lb.app.dns_name
}

output "target_group_arn" {
  description = "Target group arn"
  value       = aws_lb_target_group.app.arn
}

output "arn_suffix" {
  description = "ALB dimension suffix for CloudWatch metrics"
  value       = aws_lb.app.arn_suffix
}
output "target_group_arn_suffix" {
  description = "Target group dimension suffix for CloudWatch metrics"
  value       = aws_lb_target_group.app.arn_suffix
}
output "https_enabled" {
  value = var.enable_https
}
