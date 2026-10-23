mock_provider "aws" {}
variables {
  project_name       = "cloud-lab"
  environment        = "prod"
  github_repository  = "example/cloud-lab"
  oidc_provider_arn  = "arn:aws:iam::123456789012:oidc-provider/token.actions.githubusercontent.com"
  plan_boundary_arn  = "arn:aws:iam::123456789012:policy/prod-plan-boundary"
  apply_boundary_arn = "arn:aws:iam::123456789012:policy/prod-apply-boundary"
  plan_policy_json   = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Action\":\"ec2:DescribeVpcs\",\"Resource\":\"*\"}]}"
  apply_policy_json  = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Action\":\"ec2:DescribeVpcs\",\"Resource\":\"*\"}]}"
}
run "production_trust_is_exact" {
  command = plan
  assert {
    condition     = jsondecode(aws_iam_role.deployment["apply"].assume_role_policy).Statement[0].Condition.StringEquals["token.actions.githubusercontent.com:sub"] == "repo:example/cloud-lab:environment:prod"
    error_message = "Production apply trust must match an exact repository and protected environment."
  }
  assert {
    condition     = jsondecode(aws_iam_role.deployment["plan"].assume_role_policy).Statement[0].Condition.StringEquals["token.actions.githubusercontent.com:sub"] == "repo:example/cloud-lab:environment:prod-plan" && aws_iam_role.deployment["apply"].permissions_boundary == var.apply_boundary_arn
    error_message = "Plan and apply trust must be separated and bounded."
  }
}
