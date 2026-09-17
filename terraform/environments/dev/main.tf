locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
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
