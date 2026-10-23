variable "name_prefix" {
  type = string
}
variable "environment" {
  type = string
}
variable "project_name" {
  type = string
}
variable "level" {
  type    = string
  default = "basic"
  validation {
    condition     = contains(["basic", "enhanced", "full"], var.level)
    error_message = "Monitoring level must be basic, enhanced, or full."
  }
}
variable "compute_id" {
  type = string
}
variable "autoscaling" {
  type = bool
}
variable "alb_arn_suffix" {
  type = string
}
variable "target_group_arn_suffix" {
  type = string
}
variable "database_identifier" {
  type = string
}
variable "minimum_instances" {
  type = number
}
variable "alarm_topic_arn" {
  type    = string
  default = null
}
