
# CloudFront Distribution mit Origin Access Identity (OAI)


# OAI erstellen, damit nur CloudFront Zugriff auf den S3-Bucket hat
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "CloudFront OAI für Zugriff auf S3 Bucket"
}

# CloudFront Distribution zur Bereitstellung von statischen Dateien aus dem S3 Bucket
resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront Distribution für statisches Hosting aus S3"
  default_root_object = "home.html"

  origin {
    domain_name = var.s3_bucket_domain_name
    origin_id   = "S3-${var.s3_bucket_domain_name}"

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/${aws_cloudfront_origin_access_identity.oai.id}"
    }
  }

  default_cache_behavior {
    target_origin_id       = "S3-${var.s3_bucket_domain_name}"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1"
  }

  tags = {
    Name = "CloudFront-S3"
  }
}