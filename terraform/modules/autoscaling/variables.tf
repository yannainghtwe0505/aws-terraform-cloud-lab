variable "name_prefix" {
  type        = string
  description = "Name prefix"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
}

variable "security_group_id" {
  type        = string
  description = "Security group id"
}

variable "iam_instance_profile" {
  type        = string
  description = "Iam instance profile"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ids"
}

variable "target_group_arn" {
  type        = string
  description = "Target group arn"
}

variable "user_data" {
  type        = string
  description = "User data"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
}

variable "min_size" {
  type        = number
  description = "Min size"
}

variable "desired_capacity" {
  type        = number
  description = "Desired capacity"
}

variable "max_size" {
  type        = number
  description = "Max size"
}
