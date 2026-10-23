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

variable "subnet_id" {
  description = "Subnet id"
  type        = string
}

variable "security_group_id" {
  description = "Security group id"
  type        = string
}

variable "iam_instance_profile" {
  description = "Iam instance profile"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "ami_parameter_name" {
  description = "SSM parameter containing the AMI ID"
  type        = string
  default     = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

variable "detailed_monitoring" {
  description = "Enable detailed EC2 CloudWatch metrics"
  type        = bool
  default     = false
}
