# alb module

See [module organization](../../../docs/architecture.md) and [deployment prerequisites](../../../docs/deployment.md).

Inputs: `name_prefix`, `environment`, `project_name`, `security_group_id`, `subnet_ids`, `vpc_id`, `instance_id`, `attach_instance`, `enable_https`, `certificate_arn`, `deletion_protection`.

Outputs: `id`, `dns_name`, `target_group_arn`, `arn_suffix`, `target_group_arn_suffix`, `https_enabled`.
