output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}

output "cloudwatch_vpc_endpoint_id" {
  description = "ID des VPC Endpunktes für CloudWatch"
  value       = aws_vpc_endpoint.cloudwatch_logs.id
}

output "s3_vpc_endpoint_id" {
  description = "ID des VPC Endpunktes für S3"
  value       = aws_vpc_endpoint.s3.id
}

output "secretsmanager_vpc_endpoint_id" {
  description = "ID des VPC Endpunktes für Secrets Manager"
  value       = aws_vpc_endpoint.secretsmanager.id
}