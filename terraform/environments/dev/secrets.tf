resource "aws_secretsmanager_secret" "db" {
  name = "${local.name_prefix}/database"

  description = "Database credentials for the application"

  tags = {
    Name        = "${local.name_prefix}-database-secret"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id

  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    database = aws_db_instance.postgres.db_name
    host     = aws_db_instance.postgres.address
    port     = aws_db_instance.postgres.port
  })
}
