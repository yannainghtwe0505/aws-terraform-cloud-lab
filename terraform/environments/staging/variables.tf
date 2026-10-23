variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "staging"

  validation {
    condition = contains(
      ["staging"],
      var.environment
    )

    error_message = "This root is staging; use the matching directory for other environments."
  }
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "aws-terraform-cloud-lab"
}

variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}
variable "vpc_cidr" {
  type = string
}
variable "public_subnet_cidrs" {
  type = list(string)
}
variable "private_subnet_cidrs" {
  type = list(string)
}
variable "certificate_arn" {
  type = string
}
variable "alarm_topic_arn" {
  type = string
}
variable "db_username" {
  type      = string
  sensitive = true
}
variable "db_password" {
  type      = string
  sensitive = true
}
variable "staging_multi_az" {
  type    = bool
  default = false
}
