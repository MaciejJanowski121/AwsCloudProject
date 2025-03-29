variable "db_password" {
  description = "Passwort für die RDS-Datenbank (aus .tfvars-Datei übergeben)"
  type        = string
  sensitive   = true
}