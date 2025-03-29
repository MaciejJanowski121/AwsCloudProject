#  VPC ID für die RDS-Platzierung
variable "vpc_id" {
  description = "ID der VPC"
  type        = string
}

#  Subnet-IDs (mind. zwei für Hochverfügbarkeit , AWS braucht zwei)
variable "subnet_ids" {
  description = "IDs der Subnets für RDS"
  type        = list(string)
}

# Security Group ID für die RDS-Datenbank
variable "rds_sg_id" {
  description = "Security Group ID für RDS"
  type        = string
}

#  Benutzername für den DB-Admin
variable "db_username" {
  description = "Admin-Benutzername für RDS"
  type        = string
}

#  Passwort für den DB-Admin (sensibel)
variable "db_password" {
  description = "Admin-Passwort für RDS"
  type        = string
  sensitive   = true
}