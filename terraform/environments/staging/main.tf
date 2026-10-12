module "application_config" {
  source = "../../modules/application_config"

  application = {
    name          = local.name_prefix
    port          = local.current_config.port
    instance_type = local.current_config.instance_type

    tags = merge(
      local.common_tags,
      {
        Component = "Application"
      }
    )
  }
}
