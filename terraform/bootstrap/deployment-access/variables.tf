variable "aws_region" { type = string }
variable "project_name" { type = string }
variable "github_repository" { type = string }
variable "oidc_provider_arn" { type = string }
variable "environments" {
  description = "Reviewed per-environment boundaries and policies supplied by the AWS administrator"
  type = map(object({
    plan_boundary_arn  = string
    apply_boundary_arn = string
    plan_policy_json   = string
    apply_policy_json  = string
  }))
  validation {
    condition     = alltrue([for name in keys(var.environments) : contains(["dev", "staging", "prod"], name)])
    error_message = "Only dev, staging, and prod deployment roles are supported."
  }
}
