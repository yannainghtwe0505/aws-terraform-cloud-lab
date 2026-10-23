# autoscaling module

See [module organization](../../../docs/architecture.md) and [deployment prerequisites](../../../docs/deployment.md).

Inputs: `name_prefix`, `instance_type`, `security_group_id`, `iam_instance_profile`, `subnet_ids`, `target_group_arn`, `user_data`, `tags`, `min_size`, `desired_capacity`, `max_size`.

Outputs: `name`, `desired_capacity`, `instance_type`.
