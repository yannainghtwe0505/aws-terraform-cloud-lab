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

variable "vpc_id" {
  description = "Vpc id"
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

variable "aws_region" {
  description = "Aws region"
  type        = string
}
