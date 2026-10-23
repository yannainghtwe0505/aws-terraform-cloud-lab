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

module "platform" {
  source               = "../../modules/environment-stack"
  environment          = var.environment
  project_name         = var.project_name
  aws_region           = var.aws_region
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  certificate_arn      = var.certificate_arn
  alarm_topic_arn      = var.alarm_topic_arn
  db_username          = var.db_username
  db_password          = var.db_password
  staging_multi_az     = var.staging_multi_az
}
