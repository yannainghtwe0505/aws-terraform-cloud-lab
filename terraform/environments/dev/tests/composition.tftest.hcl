# Tests use mock AWS schemas only. No AWS resources are created.
mock_provider "aws" {
  mock_data "aws_availability_zones" {
    defaults = {
      names = ["ap-northeast-1a", "ap-northeast-1c"]
    }
  }

  mock_data "aws_ssm_parameter" {
    defaults = {
      value = "ami-0123456789abcdef0"
    }
  }
}

variables {
  aws_region           = "ap-northeast-1"
  environment          = "dev"
  project_name         = "aws-terraform-cloud-lab"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
  instance_type        = "t3.micro"
  db_username          = "testuser"
  db_password          = "test-password-only"
}

run "preserve_dev_contract" {
  command = plan

  assert {
    condition     = output.bucket_name == "aws-terraform-cloud-lab-dev-ynhtwe-2026"
    error_message = "Modularization must preserve the deployed bucket name."
  }

  assert {
    condition     = module.vpc.vpc_cidr == "10.0.0.0/16"
    error_message = "Modularization must preserve the deployed network CIDR."
  }

  assert {
    condition     = module.rds.database_name == "appdb" && output.application_port == 8080
    error_message = "The database name and application port must remain unchanged."
  }

  assert {
    condition     = output.application_name == "aws-terraform-cloud-lab" && output.application_tags.Team == "Cloud"
    error_message = "Application configuration outputs must remain compatible."
  }

  assert {
    condition     = output.application_service_ports == { api = 8080, worker = 9000 } && output.environment_status == "supported"
    error_message = "Moving tutorial locals into a module must preserve their outputs."
  }
}
