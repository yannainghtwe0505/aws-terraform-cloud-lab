terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 6.0" }
  }
}
provider "aws" { region = var.aws_region }
module "deployment_access" {
  for_each           = var.environments
  source             = "../../modules/deployment-access"
  project_name       = var.project_name
  environment        = each.key
  github_repository  = var.github_repository
  oidc_provider_arn  = var.oidc_provider_arn
  plan_boundary_arn  = each.value.plan_boundary_arn
  apply_boundary_arn = each.value.apply_boundary_arn
  plan_policy_json   = each.value.plan_policy_json
  apply_policy_json  = each.value.apply_policy_json
}
