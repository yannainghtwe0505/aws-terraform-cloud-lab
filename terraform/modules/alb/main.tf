resource "aws_lb" "app" {
  name                       = length(var.name_prefix) <= 28 ? "${var.name_prefix}-alb" : "${substr(var.name_prefix, 0, 19)}-${substr(sha1(var.name_prefix), 0, 8)}-alb"
  internal                   = false
  load_balancer_type         = "application"
  enable_deletion_protection = var.deletion_protection
  drop_invalid_header_fields = var.enable_https

  security_groups = [
    var.security_group_id
  ]

  subnets = [
    var.subnet_ids[0],
    var.subnet_ids[1]
  ]

  tags = {
    Name        = "${var.name_prefix}-alb"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Tier        = "public"
  }
}

resource "aws_lb_target_group" "app" {
  name     = length(var.name_prefix) <= 29 ? "${var.name_prefix}-tg" : "${substr(var.name_prefix, 0, 20)}-${substr(sha1(var.name_prefix), 0, 8)}-tg"
  port     = 8080
  protocol = "HTTP"

  vpc_id = var.vpc_id

  target_type = "instance"

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    port                = "8080"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 15
  }

  tags = {
    Name        = "${var.name_prefix}-tg"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = var.enable_https ? "redirect" : "forward"
    target_group_arn = var.enable_https ? null : aws_lb_target_group.app.arn

    dynamic "redirect" {
      for_each = var.enable_https ? [1] : []
      content {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  }
}

resource "aws_lb_target_group_attachment" "app" {
  count            = var.attach_instance ? 1 : 0
  target_group_arn = aws_lb_target_group.app.arn

  target_id = var.instance_id

  port = 8080
}


moved {
  from = aws_lb_target_group_attachment.app
  to   = aws_lb_target_group_attachment.app[0]
}

resource "aws_lb_listener" "https" {
  count             = var.enable_https ? 1 : 0
  load_balancer_arn = aws_lb.app.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }

  lifecycle {
    precondition {
      condition     = var.certificate_arn != null
      error_message = "HTTPS requires an ACM certificate ARN in the ALB region."
    }
  }
}
