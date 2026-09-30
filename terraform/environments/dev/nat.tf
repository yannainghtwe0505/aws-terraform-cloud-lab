resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name        = "${local.name_prefix}-nat-eip"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id

  subnet_id = module.vpc.public_subnet_ids[0]

  tags = {
    Name        = "${local.name_prefix}-nat"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }

  depends_on = [
    module.vpc
  ]
}

resource "aws_route" "private_nat" {
  route_table_id = module.vpc.private_route_table_id

  destination_cidr_block = "0.0.0.0/0"

  nat_gateway_id = aws_nat_gateway.main.id
}
