resource "aws_s3_bucket" "lab" {
  bucket = "yan-naing-htwe-aws-tf-lab-dev-20260917"

  tags = {
    Environment = "dev"
    Project     = "aws-terraform-cloud-lab"
  }
}