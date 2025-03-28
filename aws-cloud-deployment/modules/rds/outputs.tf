# 📌 Endpoint der RDS-Instanz (z. B. für Anwendung)
output "rds_endpoint" {
  description = "Endpoint der RDS-Instanz"
  value       = aws_db_instance.rds.endpoint
}

# 📌 RDS Instanz-ID
output "rds_id" {
  description = "ID der RDS-Instanz"
  value       = aws_db_instance.rds.id
}