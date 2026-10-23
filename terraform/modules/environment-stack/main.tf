locals {
  name_prefix      = "${var.project_name}-${var.environment}"
  production       = var.environment == "prod"
  instance_type    = local.production ? "t3.medium" : "t3.small"
  monitoring_level = local.production ? "full" : "enhanced"
  tags             = { Name = "${local.name_prefix}-app", Environment = var.environment, Project = var.project_name, ManagedBy = "Terraform" }
  log_agent_config = jsonencode({
    logs = { logs_collected = { files = { collect_list = [{
      file_path       = "/opt/app/server.log"
      log_group_name  = module.monitoring.log_group_name
      log_stream_name = "{instance_id}"
    }] } } }
  })
  user_data = join("\n", [file("${path.module}/../ec2/user_data.sh"), <<-EOT
    dnf install -y amazon-cloudwatch-agent
    cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<'CWEOF'
    ${local.log_agent_config}
    CWEOF
    /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
  EOT
  ])
}

module "networking" {
  source               = "../networking"
  environment          = var.environment
  project_name         = var.project_name
  name_prefix          = local.name_prefix
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}
module "security_groups" {
  source       = "../security-groups"
  environment  = var.environment
  project_name = var.project_name
  name_prefix  = local.name_prefix
  vpc_id       = module.networking.vpc_id
}
module "nat" {
  source                 = "../nat"
  environment            = var.environment
  project_name           = var.project_name
  name_prefix            = local.name_prefix
  subnet_id              = module.networking.public_subnet_ids[0]
  private_route_table_id = module.networking.private_route_table_id
  depends_on             = [module.networking]
}
module "alb" {
  source              = "../alb"
  environment         = var.environment
  project_name        = var.project_name
  name_prefix         = local.name_prefix
  security_group_id   = module.security_groups.alb_id
  subnet_ids          = module.networking.public_subnet_ids
  vpc_id              = module.networking.vpc_id
  attach_instance     = false
  enable_https        = true
  certificate_arn     = var.certificate_arn
  deletion_protection = local.production
}
module "rds" {
  source                = "../rds"
  environment           = var.environment
  project_name          = var.project_name
  name_prefix           = local.name_prefix
  subnet_ids            = module.networking.private_subnet_ids
  security_group_id     = module.security_groups.rds_id
  db_username           = var.db_username
  db_password           = var.db_password
  instance_class        = local.production ? "db.t4g.medium" : "db.t4g.small"
  multi_az              = local.production || var.staging_multi_az
  storage_encrypted     = true
  backup_retention_days = local.production ? 14 : 7
  deletion_protection   = local.production
  skip_final_snapshot   = false
  monitoring_interval   = local.production ? 1 : 60
  monitoring_role_arn   = module.iam.rds_monitoring_role_arn
  export_logs           = true
}
module "secrets" {
  source        = "../secrets"
  environment   = var.environment
  project_name  = var.project_name
  name_prefix   = local.name_prefix
  db_username   = var.db_username
  db_password   = var.db_password
  database_name = module.rds.database_name
  database_host = module.rds.address
  database_port = module.rds.port
}
module "iam" {
  source                    = "../iam"
  environment               = var.environment
  project_name              = var.project_name
  name_prefix               = local.name_prefix
  database_secret_arn       = module.secrets.arn
  enable_rds_monitoring     = true
  enable_application_logs   = true
  application_log_group_arn = module.monitoring.log_group_arn
}
module "compute" {
  source               = "../autoscaling"
  name_prefix          = local.name_prefix
  instance_type        = local.instance_type
  security_group_id    = module.security_groups.ec2_id
  iam_instance_profile = module.iam.instance_profile_name
  subnet_ids           = module.networking.private_subnet_ids
  target_group_arn     = module.alb.target_group_arn
  user_data            = local.user_data
  tags                 = local.tags
  min_size             = local.production ? 2 : 1
  desired_capacity     = local.production ? 2 : 1
  max_size             = local.production ? 4 : 2
  depends_on           = [module.nat, module.iam]
}
module "vpc_endpoints" {
  source            = "../vpc-endpoints"
  environment       = var.environment
  project_name      = var.project_name
  name_prefix       = local.name_prefix
  vpc_id            = module.networking.vpc_id
  subnet_id         = module.networking.private_subnet_ids[0]
  security_group_id = module.security_groups.vpce_id
  aws_region        = var.aws_region
}
module "monitoring" {
  source                  = "../monitoring"
  environment             = var.environment
  project_name            = var.project_name
  name_prefix             = local.name_prefix
  level                   = local.monitoring_level
  compute_id              = module.compute.name
  autoscaling             = true
  minimum_instances       = local.production ? 2 : 1
  alb_arn_suffix          = module.alb.arn_suffix
  target_group_arn_suffix = module.alb.target_group_arn_suffix
  database_identifier     = module.rds.identifier
  alarm_topic_arn         = var.alarm_topic_arn
}
