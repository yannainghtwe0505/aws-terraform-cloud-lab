output "alarm_names" { value = [for alarm in aws_cloudwatch_metric_alarm.application : alarm.alarm_name] }
output "log_group_name" { value = var.level == "basic" ? null : aws_cloudwatch_log_group.application[0].name }
output "log_group_arn" { value = var.level == "basic" ? null : aws_cloudwatch_log_group.application[0].arn }
output "level" { value = var.level }
