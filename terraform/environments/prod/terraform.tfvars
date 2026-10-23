environment          = "prod"
project_name         = "aws-terraform-cloud-lab"
aws_region           = "ap-northeast-1"
vpc_cidr             = "10.30.0.0/16"
public_subnet_cidrs  = ["10.30.1.0/24", "10.30.2.0/24"]
private_subnet_cidrs = ["10.30.11.0/24", "10.30.12.0/24"]
staging_multi_az     = false
