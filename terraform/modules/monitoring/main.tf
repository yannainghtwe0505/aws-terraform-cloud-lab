locals {
  compute_dimensions  = var.autoscaling ? { AutoScalingGroupName = var.compute_id } : { InstanceId = var.compute_id }
  alb_dimensions      = { LoadBalancer = var.alb_arn_suffix }
  database_dimensions = { DBInstanceIdentifier = var.database_identifier }
  basic_alarms = {
    compute_cpu = {
      namespace  = "AWS/EC2", metric = "CPUUtilization", statistic = "Average", threshold = 80
      comparison = "GreaterThanThreshold", dimensions = local.compute_dimensions
    }
  }
  enhanced_alarms = {
    unhealthy_targets = {
      namespace  = "AWS/ApplicationELB", metric = "UnHealthyHostCount", statistic = "Maximum", threshold = 0
      comparison = "GreaterThanThreshold", dimensions = merge(local.alb_dimensions, { TargetGroup = var.target_group_arn_suffix })
    }
    database_cpu = {
      namespace  = "AWS/RDS", metric = "CPUUtilization", statistic = "Average", threshold = 80
      comparison = "GreaterThanThreshold", dimensions = local.database_dimensions
    }
    database_storage = {
      namespace  = "AWS/RDS", metric = "FreeStorageSpace", statistic = "Minimum", threshold = 5368709120
      comparison = "LessThanThreshold", dimensions = local.database_dimensions
    }
  }
  full_alarms = {
    alb_errors = {
      namespace  = "AWS/ApplicationELB", metric = "HTTPCode_ELB_5XX_Count", statistic = "Sum", threshold = 5
      comparison = "GreaterThanThreshold", dimensions = local.alb_dimensions
    }
    latency = {
      namespace  = "AWS/ApplicationELB", metric = "TargetResponseTime", statistic = "Average", threshold = 2
      comparison = "GreaterThanThreshold", dimensions = merge(local.alb_dimensions, { TargetGroup = var.target_group_arn_suffix })
    }
    database_memory = {
      namespace  = "AWS/RDS", metric = "FreeableMemory", statistic = "Minimum", threshold = 134217728
      comparison = "LessThanThreshold", dimensions = local.database_dimensions
    }
    minimum_capacity = {
      namespace  = "AWS/AutoScaling", metric = "GroupInServiceInstances", statistic = "Minimum", threshold = var.minimum_instances
      comparison = "LessThanThreshold", dimensions = { AutoScalingGroupName = var.compute_id }
    }
  }
  alarms = merge(local.basic_alarms, var.level == "basic" ? {} : local.enhanced_alarms, var.level == "full" ? local.full_alarms : {})
}

resource "aws_cloudwatch_log_group" "application" {
  count             = var.level == "basic" ? 0 : 1
  name              = "/${var.project_name}/${var.environment}/application"
  retention_in_days = var.level == "full" ? 90 : 30
  tags              = { Project = var.project_name, Environment = var.environment, ManagedBy = "Terraform" }
}

resource "aws_cloudwatch_metric_alarm" "application" {
  for_each            = local.alarms
  alarm_name          = "${var.name_prefix}-${each.key}"
  alarm_description   = "${var.environment} ${each.key}; investigate the application and infrastructure metrics"
  namespace           = each.value.namespace
  metric_name         = each.value.metric
  statistic           = each.value.statistic
  comparison_operator = each.value.comparison
  threshold           = each.value.threshold
  period              = 60
  evaluation_periods  = 3
  datapoints_to_alarm = 2
  treat_missing_data  = each.key == "minimum_capacity" ? "breaching" : "notBreaching"
  dimensions          = each.value.dimensions
  alarm_actions       = var.alarm_topic_arn == null ? [] : [var.alarm_topic_arn]
  ok_actions          = var.alarm_topic_arn == null ? [] : [var.alarm_topic_arn]
  tags                = { Project = var.project_name, Environment = var.environment, ManagedBy = "Terraform" }

  lifecycle {
    precondition {
      condition     = var.level == "basic" || var.alarm_topic_arn != null
      error_message = "Enhanced and full monitoring require an SNS alarm topic ARN."
    }
  }
}
