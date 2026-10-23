# vpc-endpoints module

Used by the dev environment through an explicit module call. See [architecture and migration](../../../docs/architecture.md) for dependencies and state-migration guidance.

Inputs: `name_prefix`, `environment`, `project_name`, `vpc_id`, `subnet_id`, `security_group_id`, `aws_region`.

Outputs: `ssm_id`, `ssmmessages_id`, `ec2messages_id`.
