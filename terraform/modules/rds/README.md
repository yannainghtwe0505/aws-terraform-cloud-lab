# rds module

See [module organization](../../../docs/architecture.md) and [deployment prerequisites](../../../docs/deployment.md).

Inputs: `name_prefix`, `environment`, `project_name`, `subnet_ids`, `security_group_id`, `db_username`, `db_password`, `instance_class`, `multi_az`, `storage_encrypted`, `backup_retention_days`, `deletion_protection`, `skip_final_snapshot`, `monitoring_interval`, `monitoring_role_arn`, `export_logs`.

Outputs: `address`, `port`, `database_name`, `identifier`, `multi_az`, `monitoring_interval`.
