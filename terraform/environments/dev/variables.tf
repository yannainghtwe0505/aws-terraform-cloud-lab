variable "aws_region" {
  description = "AWS region used for this environment"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string

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
}

variable "vpc_cidr" {
  description = "CIDR block for the development VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "db_password" {
  description = "Password for the application database"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "Database username"
  type        = string
  sensitive   = true
}

variable "security_rules" {
  description = "Security group ingress rules"

  type = list(object({
    port        = number
    protocol    = string
    description = string
    cidr_blocks = list(string)
  }))

  default = [
    {
      port        = 80
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 443
      protocol    = "tcp"
      description = "HTTPS"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "optional_app_name" {
  description = "Optional application name"
  type        = string
  default     = null
}

variable "enable_https" {
  type    = bool
  default = false
}
variable "certificate_arn" {
  type    = string
  default = null
}
variable "alarm_topic_arn" {
  type    = string
  default = null
}
