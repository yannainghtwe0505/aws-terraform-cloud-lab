resource "aws_s3_bucket" "lab" {
  bucket = var.bucket_name

  tags = {
    Name        = "${var.name_prefix}-bucket"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}
