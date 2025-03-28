output "cloudfront_distribution_domain_name" {
  description = "Domain-Name der erstellten CloudFront Distribution"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "oai_iam_arn" {
  description = "IAM ARN der Origin Access Identity (OAI) für Zugriff auf S3"
  value       = aws_cloudfront_origin_access_identity.oai.iam_arn
}