output "arn" {
  description = "Arn"
  value       = aws_secretsmanager_secret.db.arn
}
