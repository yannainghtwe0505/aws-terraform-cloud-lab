locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

module "vpc" {
  # Keep the module label to preserve existing resource addresses in state.
  source = "../../modules/networking"

  name_prefix          = local.name_prefix
  environment          = var.environment
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "application_config" {
  source = "../../modules/application_config"

  application = {
    name          = "aws-terraform-cloud-lab"
    port          = 8080
    instance_type = "t3.micro"

    tags = {
      Component = "Application"
      Team      = "Cloud"
    }
  }
}

module "security_groups" {
  source = "../../modules/security-groups"

  name_prefix  = local.name_prefix
  environment  = var.environment
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "ec2" {
  source = "../../modules/ec2"

  name_prefix          = local.name_prefix
  environment          = var.environment
  project_name         = var.project_name
  subnet_id            = module.vpc.private_subnet_ids[0]
  security_group_id    = module.security_groups.ec2_id
  iam_instance_profile = module.iam.instance_profile_name
  instance_type        = var.instance_type
}

module "alb" {
  source = "../../modules/alb"

  name_prefix       = local.name_prefix
  environment       = var.environment
  project_name      = var.project_name
  security_group_id = module.security_groups.alb_id
  subnet_ids        = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id
  instance_id       = module.ec2.instance_id
  enable_https      = var.enable_https
  certificate_arn   = var.certificate_arn
}

module "rds" {
  source = "../../modules/rds"

  name_prefix       = local.name_prefix
  environment       = var.environment
  project_name      = var.project_name
  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.security_groups.rds_id
  db_username       = var.db_username
  db_password       = var.db_password
}

module "iam" {
  source = "../../modules/iam"

  name_prefix         = local.name_prefix
  environment         = var.environment
  project_name        = var.project_name
  database_secret_arn = module.secrets.arn
}

module "nat" {
  source = "../../modules/nat"

  name_prefix            = local.name_prefix
  environment            = var.environment
  project_name           = var.project_name
  subnet_id              = module.vpc.public_subnet_ids[0]
  private_route_table_id = module.vpc.private_route_table_id

  depends_on = [module.vpc]
}

module "vpc_endpoints" {
  source = "../../modules/vpc-endpoints"

  name_prefix       = local.name_prefix
  environment       = var.environment
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.vpc.private_subnet_ids[0]
  security_group_id = module.security_groups.vpce_id
  aws_region        = var.aws_region
}

module "secrets" {
  source = "../../modules/secrets"

  name_prefix   = local.name_prefix
  environment   = var.environment
  project_name  = var.project_name
  db_username   = var.db_username
  db_password   = var.db_password
  database_name = module.rds.database_name
  database_host = module.rds.address
  database_port = module.rds.port
}

module "storage" {
  source = "../../modules/storage"

  name_prefix  = local.name_prefix
  environment  = var.environment
  project_name = var.project_name
  bucket_name  = "${local.name_prefix}-ynhtwe-2026"
}

module "practice" {
  source            = "../../modules/practice"
  environment       = var.environment
  project_name      = var.project_name
  optional_app_name = var.optional_app_name
}

module "environment_info" {
  source = "../../modules/environment-info"
}

module "monitoring" {
  source                  = "../../modules/monitoring"
  name_prefix             = local.name_prefix
  environment             = var.environment
  project_name            = var.project_name
  level                   = "basic"
  compute_id              = module.ec2.instance_id
  autoscaling             = false
  minimum_instances       = 1
  alb_arn_suffix          = module.alb.arn_suffix
  target_group_arn_suffix = module.alb.target_group_arn_suffix
  database_identifier     = module.rds.identifier
  alarm_topic_arn         = var.alarm_topic_arn
}
