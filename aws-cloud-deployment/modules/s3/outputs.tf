# ARN des erstellten S3 Buckets
output "s3_bucket_arn" {
  description = "ARN des erstellten S3 Buckets"
  value       = aws_s3_bucket.s3_bucket.arn
}

#Domain-Name des Buckets für die Verwendung in CloudFront
output "s3_bucket_domain_name" {
  description = "Regionaler Domain-Name des Buckets zur Verwendung in CloudFront"
  value       = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
}

# Website-Endpunkt (für statisches Hosting)
output "s3_website_endpoint" {
  description = "Website-Endpunkt für statisches Hosting des Buckets"
  value       = aws_s3_bucket_website_configuration.s3_website.website_endpoint
}