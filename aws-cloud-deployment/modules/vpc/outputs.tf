output "vpc_id" {
  description = "ID der erstellten VPC"
  value       = aws_vpc.main.id
}

output "igw_id" {
  description = "ID des Internet Gateways"
  value       = aws_internet_gateway.main.id
}