# Preserve Day 6 state address after relocating/renaming the ingress rule into rds.tf.
moved {
  from = aws_vpc_security_group_ingress_rule.rds_from_ec2
  to   = aws_vpc_security_group_ingress_rule.rds_postgres
}

resource "aws_security_group" "rds" {
  name        = "${local.name_prefix}-rds-sg"
  description = "Security group for PostgreSQL RDS"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name        = "${local.name_prefix}-rds-sg"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Tier        = "database"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds_postgres" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.ec2.id

  from_port   = 5432
  to_port     = 5432
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "rds_all" {
  security_group_id = aws_security_group.rds.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_db_subnet_group" "app" {
  name = "${local.name_prefix}-db-subnet-group"

  subnet_ids = [
    module.vpc.private_subnet_ids[0],
    module.vpc.private_subnet_ids[1]
  ]

  tags = {
    Name        = "${local.name_prefix}-db-subnet-group"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_db_instance" "postgres" {
  identifier = "${local.name_prefix}-postgres"

  engine         = "postgres"
  engine_version = "17"

  instance_class = "db.t4g.micro"

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "appdb"
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.app.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  publicly_accessible = false

  skip_final_snapshot = true

  backup_retention_period = 0

  deletion_protection = false

  tags = {
    Name        = "${local.name_prefix}-postgres"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Tier        = "database"
  }
}
