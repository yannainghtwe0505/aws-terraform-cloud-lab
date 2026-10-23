# practice module

Used by the dev environment through an explicit module call. See [architecture and migration](../../../docs/architecture.md) for dependencies and state-migration guidance.

Inputs: `environment`, `project_name`, `optional_app_name`.

Outputs: `application_config_id`, `application_deployment_id`, `environment_upper`, `environment_descriptions`, `application_ports`, `security_rules`, `application_rule_names`, `application_rule_map`, `dev_instance_size`, `recommended_instance_size`, `application_port`, `final_app_name`, `is_supported_environment`, `environment_status`, `selected_instance_size`, `unique_applications`, `application_list`, `final_tags`, `all_ports`, `all_subnets`, `unique_ports`, `sorted_ports`, `service_names`, `service_port_values`, `service_names_upper`, `application_service_ports`.

Includes a `prevent_destroy` resource from the lifecycle exercise; its protection is preserved.
