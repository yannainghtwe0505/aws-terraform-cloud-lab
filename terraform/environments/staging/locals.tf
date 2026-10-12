locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

  environment_config = {
    dev = {
      instance_type = "t3.micro"
      port          = 8080
    }

    staging = {
      instance_type = "t3.small"
      port          = 8080
    }

    prod = {
      instance_type = "t3.medium"
      port          = 8080
    }
  }

  current_config = local.environment_config[var.environment]
}
