# security-groups module

Used by the dev environment through an explicit module call. See [architecture and migration](../../../docs/architecture.md) for dependencies and state-migration guidance.

Inputs: `name_prefix`, `environment`, `project_name`, `vpc_id`.

Outputs: `alb_id`, `ec2_id`, `rds_id`, `vpce_id`.
