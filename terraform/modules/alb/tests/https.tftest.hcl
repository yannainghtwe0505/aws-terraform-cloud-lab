mock_provider "aws" {}
variables {
  name_prefix       = "aws-terraform-cloud-lab-staging"
  environment       = "staging"
  project_name      = "aws-terraform-cloud-lab"
  vpc_id            = "vpc-12345678"
  security_group_id = "sg-12345678"
  subnet_ids        = ["subnet-11111111", "subnet-22222222"]
  attach_instance   = false
  enable_https      = true
  certificate_arn   = "arn:aws:acm:ap-northeast-1:123456789012:certificate/test"
}
run "tls_and_scaling_attachment" {
  command = plan
  assert {
    condition     = aws_lb_listener.http.default_action[0].type == "redirect" && aws_lb_listener.https[0].protocol == "HTTPS"
    error_message = "HTTP must redirect to the required TLS listener."
  }
  assert {
    condition     = length(aws_lb_target_group_attachment.app) == 0
    error_message = "Auto Scaling must own instance registration."
  }
  assert {
    condition     = length(aws_lb.app.name) <= 32 && length(aws_lb_target_group.app.name) <= 32
    error_message = "Long environment prefixes must respect AWS naming limits."
  }
}
run "missing_certificate_is_rejected" {
  command = plan
  variables { certificate_arn = null }
  expect_failures = [aws_lb_listener.https]
}
