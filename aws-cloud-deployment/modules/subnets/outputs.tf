# Gibt die IDs der öffentlichen Subnetze zurück
output "public_subnet_ids" {
  description = "IDs der öffentlichen Subnetze"
  value       = aws_subnet.public[*].id
}

# Gibt die IDs der privaten Subnetze zurück
output "private_subnet_ids" {
  description = "IDs der privaten Subnetze"
  value       = aws_subnet.private[*].id
}