#  Erstellt ein neues Secret in AWS Secrets Manager
resource "aws_secretsmanager_secret" "db_password" {
  name = "rds-db-password-v3"
}

#  Fügt eine Secret-Version mit dem Datenbankpasswort hinzu
resource "aws_secretsmanager_secret_version" "db_password_version" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = var.db_password
}