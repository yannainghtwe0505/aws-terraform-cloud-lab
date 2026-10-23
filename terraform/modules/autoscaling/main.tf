data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_launch_template" "application" {
  name_prefix            = "${var.name_prefix}-"
  image_id               = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  user_data              = base64encode(var.user_data)
  update_default_version = true

  iam_instance_profile { name = var.iam_instance_profile }
  monitoring { enabled = true }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      encrypted             = true
      volume_type           = "gp3"
      volume_size           = 16
      delete_on_termination = true
    }
  }
  tag_specifications {
    resource_type = "instance"
    tags          = var.tags
  }
  tag_specifications {
    resource_type = "volume"
    tags          = var.tags
  }
  tags = var.tags
}

resource "aws_autoscaling_group" "application" {
  name                      = "${var.name_prefix}-app"
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  vpc_zone_identifier       = var.subnet_ids
  target_group_arns         = [var.target_group_arn]
  enabled_metrics           = ["GroupInServiceInstances", "GroupDesiredCapacity"]
  health_check_type         = "ELB"
  health_check_grace_period = 180

  launch_template {
    id      = aws_launch_template.application.id
    version = tostring(aws_launch_template.application.latest_version)
  }
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 100
      max_healthy_percentage = 200
      instance_warmup        = 180
    }
  }
  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
  lifecycle {
    ignore_changes = [desired_capacity]
    precondition {
      condition     = var.min_size <= var.desired_capacity && var.desired_capacity <= var.max_size
      error_message = "Auto Scaling capacity must satisfy min <= desired <= max."
    }
  }
}

resource "aws_autoscaling_policy" "cpu" {
  name                   = "${var.name_prefix}-cpu"
  autoscaling_group_name = aws_autoscaling_group.application.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification { predefined_metric_type = "ASGAverageCPUUtilization" }
    target_value = 60
  }
}
