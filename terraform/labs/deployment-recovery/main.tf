terraform {
  required_version = ">= 1.5.0"
}

variable "application_version" {
  description = "Application deployment version"
  type        = string
  default     = "1.0"

  validation {
    condition = contains(
      ["1.0", "2.0"],
      var.application_version
    )

    error_message = "Only versions 1.0 and 2.0 are allowed."
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

resource "terraform_data" "application" {
  input = {
    name        = "cloud-lab"
    environment = var.environment
    version     = var.application_version
  }
}

output "application_version" {
  value = terraform_data.application.output.version
}

output "environment" {
  value = terraform_data.application.output.environment
}
