resource "aws_security_group" "vpce" {
  name        = "${local.name_prefix}-vpce-sg"
  description = "Security group for VPC interface endpoints"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name        = "${local.name_prefix}-vpce-sg"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Tier        = "network"
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpce_https" {
  security_group_id            = aws_security_group.vpce.id
  referenced_security_group_id = aws_security_group.ec2.id

  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "vpce_all" {
  security_group_id = aws_security_group.vpce.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id = aws_vpc.main.id

  service_name = "com.amazonaws.${var.aws_region}.ssm"

  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.private[0].id
  ]

  security_group_ids = [
    aws_security_group.vpce.id
  ]

  private_dns_enabled = true

  tags = {
    Name        = "${local.name_prefix}-ssm-endpoint"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id = aws_vpc.main.id

  service_name = "com.amazonaws.${var.aws_region}.ssmmessages"

  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.private[0].id
  ]

  security_group_ids = [
    aws_security_group.vpce.id
  ]

  private_dns_enabled = true

  tags = {
    Name        = "${local.name_prefix}-ssmmessages-endpoint"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id = aws_vpc.main.id

  service_name = "com.amazonaws.${var.aws_region}.ec2messages"

  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.private[0].id
  ]

  security_group_ids = [
    aws_security_group.vpce.id
  ]

  private_dns_enabled = true

  tags = {
    Name        = "${local.name_prefix}-ec2messages-endpoint"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}
