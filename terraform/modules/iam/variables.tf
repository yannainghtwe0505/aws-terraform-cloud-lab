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

variable "database_secret_arn" {
  description = "Database secret arn"
  type        = string
}

variable "enable_rds_monitoring" {
  description = "Create the least-privilege RDS Enhanced Monitoring service role"
  type        = bool
  default     = false
}

variable "application_log_group_arn" {
  type    = string
  default = null
}
variable "enable_application_logs" {
  type    = bool
  default = false
}
