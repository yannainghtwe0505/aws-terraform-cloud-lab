resource "aws_db_subnet_group" "app" {
  name = "${var.name_prefix}-db-subnet-group"

  subnet_ids = [
    var.subnet_ids[0],
    var.subnet_ids[1]
  ]

  tags = {
    Name        = "${var.name_prefix}-db-subnet-group"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_db_instance" "postgres" {
  identifier = "${var.name_prefix}-postgres"

  engine         = "postgres"
  engine_version = "17"

  instance_class = var.instance_class

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "appdb"
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.app.name
  vpc_security_group_ids = [var.security_group_id]

  publicly_accessible             = false
  multi_az                        = var.multi_az
  storage_encrypted               = var.storage_encrypted
  copy_tags_to_snapshot           = true
  monitoring_interval             = var.monitoring_interval
  monitoring_role_arn             = var.monitoring_role_arn
  enabled_cloudwatch_logs_exports = var.export_logs ? ["postgresql", "upgrade"] : []

  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.name_prefix}-final"

  backup_retention_period = var.backup_retention_days

  deletion_protection = var.deletion_protection

  tags = {
    Name        = "${var.name_prefix}-postgres"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Tier        = "database"
  }
}
