variable "project_name" { type = string }
variable "environment" {
  type = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Use dev, staging, or prod."
  }
}
variable "github_repository" {
  type = string
  validation {
    condition     = can(regex("^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$", var.github_repository))
    error_message = "Supply the exact GitHub owner/repository, without wildcards."
  }
}
variable "oidc_provider_arn" { type = string }
variable "plan_boundary_arn" { type = string }
variable "apply_boundary_arn" { type = string }
variable "plan_policy_json" { type = string }
variable "apply_policy_json" { type = string }
