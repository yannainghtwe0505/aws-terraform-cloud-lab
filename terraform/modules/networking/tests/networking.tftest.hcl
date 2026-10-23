# Mock provider tests require Terraform >= 1.7; they do not contact AWS.
mock_provider "aws" {
  mock_data "aws_availability_zones" {
    defaults = {
      names = ["ap-northeast-1a", "ap-northeast-1c"]
    }
  }
}

run "dev_network_defaults" {
  command = plan

  variables {
    environment          = "dev"
    vpc_cidr             = "10.10.0.0/16"
    public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24"]
    private_subnet_cidrs = ["10.10.11.0/24", "10.10.12.0/24"]
  }

  assert {
    condition     = aws_vpc.main.tags.Name == "aws-terraform-cloud-lab-dev-vpc"
    error_message = "The default naming prefix must include the project and environment."
  }

  assert {
    condition     = aws_subnet.public[1].cidr_block == "10.10.2.0/24" && aws_subnet.private[0].cidr_block == "10.10.11.0/24"
    error_message = "The module must use the environment's public and private subnet inputs."
  }
}

run "prod_network_inputs" {
  command = plan

  variables {
    environment          = "prod"
    vpc_cidr             = "10.30.0.0/16"
    public_subnet_cidrs  = ["10.30.1.0/24", "10.30.2.0/24"]
    private_subnet_cidrs = ["10.30.11.0/24", "10.30.12.0/24"]
  }

  assert {
    condition     = aws_vpc.main.cidr_block == "10.30.0.0/16" && aws_vpc.main.tags.Environment == "prod"
    error_message = "Production inputs must determine the VPC CIDR and environment tag."
  }
}

run "existing_dev_names" {
  command = plan

  variables {
    environment          = "dev"
    project_name         = "existing-project"
    name_prefix          = "existing-prefix"
    vpc_cidr             = "10.0.0.0/16"
    public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
  }

  assert {
    condition     = aws_vpc.main.tags.Name == "existing-prefix-vpc" && aws_subnet.public[0].tags.Name == "existing-prefix-public-1"
    error_message = "Explicit naming inputs must preserve existing deployed names."
  }
}
