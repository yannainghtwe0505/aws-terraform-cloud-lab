variable "name_prefix" {
  description = "Name prefix"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "security_group_id" {
  description = "Security group id"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet ids"
  type        = list(string)
}

variable "vpc_id" {
  description = "Vpc id"
  type        = string
}

variable "instance_id" {
  description = "Instance id"
  type        = string
  default     = null
}

variable "attach_instance" {
  description = "Attach a standalone EC2 instance; disable for Auto Scaling"
  type        = bool
  default     = true
}

variable "enable_https" {
  description = "Redirect HTTP to HTTPS and enable TLS listener"
  type        = bool
  default     = false
}

variable "certificate_arn" {
  description = "ACM certificate ARN for the HTTPS listener"
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "Protect the ALB against accidental deletion"
  type        = bool
  default     = false
}
