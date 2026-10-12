variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "staging"

  validation {
    condition = contains(
      ["dev", "staging", "prod"],
      var.environment
    )

    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "aws-terraform-cloud-lab"
}
