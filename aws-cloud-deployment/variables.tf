variable "aws_region" {
  description = "AWS-Region für die Bereitstellung"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  description = "CIDR-Block für die VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "CIDR-Blöcke für öffentliche Subnetze"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "private_subnets" {
  description = "CIDR-Blöcke für private Subnetze"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "db_username" {
  description = "Benutzername für die RDS-Datenbank"
  type        = string
}

variable "db_password" {
  description = "Passwort für die RDS-Datenbank (aus .tfvars geladen)"
  type        = string
  sensitive   = true
}