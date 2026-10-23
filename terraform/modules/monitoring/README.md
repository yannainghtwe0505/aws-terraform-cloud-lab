# monitoring module

See [module organization](../../../docs/architecture.md) and [deployment prerequisites](../../../docs/deployment.md).

Inputs: `name_prefix`, `environment`, `project_name`, `level`, `compute_id`, `autoscaling`, `alb_arn_suffix`, `target_group_arn_suffix`, `database_identifier`, `minimum_instances`, `alarm_topic_arn`.

Outputs: `alarm_names`, `log_group_name`, `log_group_arn`, `level`.
