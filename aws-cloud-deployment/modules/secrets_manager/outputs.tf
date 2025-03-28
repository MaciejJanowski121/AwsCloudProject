output "secret_arn" {
  description = "ARN des Secrets mit dem Datenbankpasswort"
  value       = aws_secretsmanager_secret.db_password.arn
}