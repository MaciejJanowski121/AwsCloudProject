#Name des S3 Buckets
variable "s3_bucket_name" {
  description = "Der Name des S3 Buckets"
  type        = string
}

# IAM ARN der Origin Access Identity von CloudFront
variable "oai_iam_arn" {
  description = "IAM ARN der CloudFront Origin Access Identity (OAI)"
  type        = string
}

# ID des S3 VPC Endpoints (für privaten Zugriff durch EC2)
variable "s3_vpc_endpoint_id" {
  description = "ID des VPC Endpoints für S3 (für EC2-Zugriff)"
  type        = string
}