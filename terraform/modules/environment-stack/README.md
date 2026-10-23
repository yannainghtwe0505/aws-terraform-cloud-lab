# environment-stack module

See [module organization](../../../docs/architecture.md) and [deployment prerequisites](../../../docs/deployment.md).

Inputs: `environment`, `project_name`, `aws_region`, `vpc_cidr`, `public_subnet_cidrs`, `private_subnet_cidrs`, `certificate_arn`, `alarm_topic_arn`, `db_username`, `db_password`, `staging_multi_az`.

Outputs: `vpc_id`, `public_subnet_ids`, `private_subnet_ids`, `application_instance_type`, `autoscaling_group_name`, `minimum_instances`, `maximum_instances`, `database_multi_az`, `https_enabled`, `alb_dns_name`, `database_endpoint`, `monitoring_level`, `alarm_names`, `rds_monitoring_interval`.
