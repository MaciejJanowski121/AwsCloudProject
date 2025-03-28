output "vpc_id" {
  description = "Die ID der erstellten VPC"
  value       = module.vpc.vpc_id
}

output "igw_id" {
  description = "ID des Internet Gateways"
  value       = module.vpc.igw_id
}

output "public_subnets" {
  description = "IDs der erstellten Public Subnets"
  value       = module.subnets.public_subnet_ids
}

output "private_subnets" {
  description = "IDs der erstellten Private Subnets"
  value       = module.subnets.private_subnet_ids
}

output "alb_dns_name" {
  description = "DNS-Name des Load Balancers"
  value       = module.alb.alb_dns_name
}

output "rds_endpoint" {
  description = "RDS Endpoint zur Verbindung mit der Datenbank"
  value       = module.rds.rds_endpoint
}

output "secret_arn" {
  description = "ARN des RDS-Datenbankpassworts im Secrets Manager"
  value       = module.secrets_manager.secret_arn
}

output "ec2_sg_id" {
  description = "ID der Security Group für EC2"
  value       = module.security_groups.ec2_sg_id
}

output "s3_bucket_arn" {
  description = "ARN des S3 Buckets"
  value       = module.s3.s3_bucket_arn
}

output "cloudfront_domain" {
  description = "CloudFront-Domain für die statische Seite"
  value       = module.cloudfront.cloudfront_distribution_domain_name
}