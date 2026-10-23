# deployment-access module

See [module organization](../../../docs/architecture.md) and [deployment prerequisites](../../../docs/deployment.md).

Inputs: `project_name`, `environment`, `github_repository`, `oidc_provider_arn`, `plan_boundary_arn`, `apply_boundary_arn`, `plan_policy_json`, `apply_policy_json`.

Outputs: `plan_role_arn`, `apply_role_arn`.
