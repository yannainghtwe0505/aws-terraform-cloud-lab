locals {
  roles = {
    plan = {
      github_environment = "${var.environment}-plan"
      boundary           = var.plan_boundary_arn
      policy             = var.plan_policy_json
    }
    apply = {
      github_environment = var.environment
      boundary           = var.apply_boundary_arn
      policy             = var.apply_policy_json
    }
  }
}
resource "aws_iam_role" "deployment" {
  for_each             = local.roles
  name                 = "${var.project_name}-${var.environment}-${each.key}"
  permissions_boundary = each.value.boundary
  max_session_duration = 3600
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Federated = var.oidc_provider_arn }
      Action    = "sts:AssumeRoleWithWebIdentity"
      Condition = { StringEquals = {
        "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
        "token.actions.githubusercontent.com:sub" = "repo:${var.github_repository}:environment:${each.value.github_environment}"
      } }
    }]
  })
  tags = { Environment = var.environment, Project = var.project_name, ManagedBy = "Terraform" }
}
resource "aws_iam_role_policy" "deployment" {
  for_each = local.roles
  name     = "${var.environment}-${each.key}-reviewed-permissions"
  role     = aws_iam_role.deployment[each.key].id
  policy   = each.value.policy
}
