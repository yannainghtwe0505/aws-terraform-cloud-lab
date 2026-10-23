variable "environment" {
  description = "Environment"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "optional_app_name" {
  description = "Optional app name"
  type        = string
  default     = null
}
