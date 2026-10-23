resource "aws_secretsmanager_secret" "db" {
  name = "${var.name_prefix}/database"

  description = "Database credentials for the application"

  tags = {
    Name        = "${var.name_prefix}-database-secret"
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
    database = var.database_name
    host     = var.database_host
    port     = var.database_port
  })
}
