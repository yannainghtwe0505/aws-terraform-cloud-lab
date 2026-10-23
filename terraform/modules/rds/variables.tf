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

variable "subnet_ids" {
  description = "Subnet ids"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group id"
  type        = string
}

variable "db_username" {
  description = "Db username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Db password"
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "Instance class"
  type        = string
  default     = "db.t4g.micro"
}

variable "multi_az" {
  description = "Multi az"
  type        = bool
  default     = false
}

variable "storage_encrypted" {
  description = "Storage encrypted"
  type        = bool
  default     = false
}

variable "backup_retention_days" {
  description = "Backup retention days"
  type        = number
  default     = 0
}

variable "deletion_protection" {
  description = "Deletion protection"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot"
  type        = bool
  default     = true
}

variable "monitoring_interval" {
  description = "Monitoring interval"
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "Monitoring role arn"
  type        = string
  default     = null
}

variable "export_logs" {
  description = "Export logs"
  type        = bool
  default     = false
}
