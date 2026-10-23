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

variable "private_route_table_id" {
  description = "Private route table id"
  type        = string
}
