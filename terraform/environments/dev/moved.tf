# Preserve existing state addresses after moving VPC resources into the module.

moved {
  from = aws_vpc.main
  to   = module.vpc.aws_vpc.main
}

moved {
  from = aws_internet_gateway.main
  to   = module.vpc.aws_internet_gateway.main
}

moved {
  from = aws_subnet.public[0]
  to   = module.vpc.aws_subnet.public[0]
}

moved {
  from = aws_subnet.public[1]
  to   = module.vpc.aws_subnet.public[1]
}

moved {
  from = aws_subnet.private[0]
  to   = module.vpc.aws_subnet.private[0]
}

moved {
  from = aws_subnet.private[1]
  to   = module.vpc.aws_subnet.private[1]
}

moved {
  from = aws_route_table.public
  to   = module.vpc.aws_route_table.public
}

moved {
  from = aws_route.public_internet
  to   = module.vpc.aws_route.public_internet
}

moved {
  from = aws_route_table_association.public[0]
  to   = module.vpc.aws_route_table_association.public[0]
}

moved {
  from = aws_route_table_association.public[1]
  to   = module.vpc.aws_route_table_association.public[1]
}

moved {
  from = aws_route_table.private
  to   = module.vpc.aws_route_table.private
}

moved {
  from = aws_route_table_association.private[0]
  to   = module.vpc.aws_route_table_association.private[0]
}

moved {
  from = aws_route_table_association.private[1]
  to   = module.vpc.aws_route_table_association.private[1]
}

moved {
  from = aws_vpc_security_group_ingress_rule.rds_from_ec2
  to   = aws_vpc_security_group_ingress_rule.rds_postgres
}

moved {
  from = aws_security_group.alb
  to   = module.security_groups.aws_security_group.alb
}

moved {
  from = aws_vpc_security_group_ingress_rule.alb_http
  to   = module.security_groups.aws_vpc_security_group_ingress_rule.alb_http
}

moved {
  from = aws_vpc_security_group_ingress_rule.alb_https
  to   = module.security_groups.aws_vpc_security_group_ingress_rule.alb_https
}

moved {
  from = aws_vpc_security_group_egress_rule.alb_all
  to   = module.security_groups.aws_vpc_security_group_egress_rule.alb_all
}

moved {
  from = aws_security_group.ec2
  to   = module.security_groups.aws_security_group.ec2
}

moved {
  from = aws_vpc_security_group_ingress_rule.ec2_from_alb
  to   = module.security_groups.aws_vpc_security_group_ingress_rule.ec2_from_alb
}

moved {
  from = aws_vpc_security_group_egress_rule.ec2_all
  to   = module.security_groups.aws_vpc_security_group_egress_rule.ec2_all
}

moved {
  from = aws_security_group.rds
  to   = module.security_groups.aws_security_group.rds
}

moved {
  from = aws_vpc_security_group_ingress_rule.rds_postgres
  to   = module.security_groups.aws_vpc_security_group_ingress_rule.rds_postgres
}

moved {
  from = aws_vpc_security_group_egress_rule.rds_all
  to   = module.security_groups.aws_vpc_security_group_egress_rule.rds_all
}

moved {
  from = aws_security_group.vpce
  to   = module.security_groups.aws_security_group.vpce
}

moved {
  from = aws_vpc_security_group_ingress_rule.vpce_https
  to   = module.security_groups.aws_vpc_security_group_ingress_rule.vpce_https
}

moved {
  from = aws_vpc_security_group_egress_rule.vpce_all
  to   = module.security_groups.aws_vpc_security_group_egress_rule.vpce_all
}

moved {
  from = aws_instance.app
  to   = module.ec2.aws_instance.app
}

moved {
  from = aws_lb.app
  to   = module.alb.aws_lb.app
}

moved {
  from = aws_lb_target_group.app
  to   = module.alb.aws_lb_target_group.app
}

moved {
  from = aws_lb_listener.http
  to   = module.alb.aws_lb_listener.http
}

moved {
  from = aws_lb_target_group_attachment.app
  to   = module.alb.aws_lb_target_group_attachment.app
}

moved {
  from = aws_db_subnet_group.app
  to   = module.rds.aws_db_subnet_group.app
}

moved {
  from = aws_db_instance.postgres
  to   = module.rds.aws_db_instance.postgres
}

moved {
  from = aws_iam_role.ec2
  to   = module.iam.aws_iam_role.ec2
}

moved {
  from = aws_iam_instance_profile.ec2
  to   = module.iam.aws_iam_instance_profile.ec2
}

moved {
  from = aws_iam_role_policy_attachment.ssm
  to   = module.iam.aws_iam_role_policy_attachment.ssm
}

moved {
  from = aws_iam_policy.secrets_manager_read
  to   = module.iam.aws_iam_policy.secrets_manager_read
}

moved {
  from = aws_iam_role_policy_attachment.secrets_manager_read
  to   = module.iam.aws_iam_role_policy_attachment.secrets_manager_read
}

moved {
  from = aws_eip.nat
  to   = module.nat.aws_eip.nat
}

moved {
  from = aws_nat_gateway.main
  to   = module.nat.aws_nat_gateway.main
}

moved {
  from = aws_route.private_nat
  to   = module.nat.aws_route.private_nat
}

moved {
  from = aws_vpc_endpoint.ssm
  to   = module.vpc_endpoints.aws_vpc_endpoint.ssm
}

moved {
  from = aws_vpc_endpoint.ssmmessages
  to   = module.vpc_endpoints.aws_vpc_endpoint.ssmmessages
}

moved {
  from = aws_vpc_endpoint.ec2messages
  to   = module.vpc_endpoints.aws_vpc_endpoint.ec2messages
}

moved {
  from = aws_secretsmanager_secret.db
  to   = module.secrets.aws_secretsmanager_secret.db
}

moved {
  from = aws_secretsmanager_secret_version.db
  to   = module.secrets.aws_secretsmanager_secret_version.db
}

moved {
  from = aws_s3_bucket.lab
  to   = module.storage.aws_s3_bucket.lab
}

moved {
  from = terraform_data.application_config
  to   = module.practice.terraform_data.application_config
}

moved {
  from = terraform_data.application_deployment
  to   = module.practice.terraform_data.application_deployment
}

moved {
  from = terraform_data.replaceable
  to   = module.practice.terraform_data.replaceable
}

moved {
  from = terraform_data.protected_resource
  to   = module.practice.terraform_data.protected_resource
}

moved {
  from = terraform_data.managed_resource
  to   = module.practice.terraform_data.managed_resource
}

moved {
  from = data.aws_ssm_parameter.amazon_linux_ami
  to   = module.ec2.data.aws_ssm_parameter.amazon_linux_ami
}

moved {
  from = data.aws_caller_identity.current
  to   = module.environment_info.data.aws_caller_identity.current
}

moved {
  from = data.aws_region.current
  to   = module.environment_info.data.aws_region.current
}

moved {
  from = data.aws_availability_zones.available
  to   = module.environment_info.data.aws_availability_zones.available
}
