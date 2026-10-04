locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

data "aws_ssm_parameter" "amazon_linux_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

module "vpc" {
  source = "../../modules/vpc"

  name_prefix          = local.name_prefix
  environment          = var.environment
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

resource "aws_s3_bucket" "lab" {
  bucket = "${local.name_prefix}-ynhtwe-2026"

  tags = {
    Name        = "${local.name_prefix}-bucket"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}
