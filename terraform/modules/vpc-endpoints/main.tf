resource "aws_vpc_endpoint" "ssm" {
  vpc_id = var.vpc_id

  service_name = "com.amazonaws.${var.aws_region}.ssm"

  vpc_endpoint_type = "Interface"

  subnet_ids = [
    var.subnet_id
  ]

  security_group_ids = [
    var.security_group_id
  ]

  private_dns_enabled = true

  tags = {
    Name        = "${var.name_prefix}-ssm-endpoint"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id = var.vpc_id

  service_name = "com.amazonaws.${var.aws_region}.ssmmessages"

  vpc_endpoint_type = "Interface"

  subnet_ids = [
    var.subnet_id
  ]

  security_group_ids = [
    var.security_group_id
  ]

  private_dns_enabled = true

  tags = {
    Name        = "${var.name_prefix}-ssmmessages-endpoint"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id = var.vpc_id

  service_name = "com.amazonaws.${var.aws_region}.ec2messages"

  vpc_endpoint_type = "Interface"

  subnet_ids = [
    var.subnet_id
  ]

  security_group_ids = [
    var.security_group_id
  ]

  private_dns_enabled = true

  tags = {
    Name        = "${var.name_prefix}-ec2messages-endpoint"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}
