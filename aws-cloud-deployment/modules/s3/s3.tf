

#  Erstellung eines S3 Buckets mit statischer Website-Hosting-Funktion, Zugriffskontrolle über CloudFront und VPC Endpoint.


# Hauptressourcen für den S3 Bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket_name
}

# Übertragung der Objekt-Eigentümerschaft auf den Bucket-Besitzer
resource "aws_s3_bucket_ownership_controls" "s3_ownership" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Aktivierung von statischem Website-Hosting
resource "aws_s3_bucket_website_configuration" "s3_website" {
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = "home.html"
  }

  error_document {
    key = "error.html"
  }
}

# Blockieren des öffentlichen Zugriffs
resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Aktivierung von Versionierung für zusätzliche Datensicherheit
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 Bucket-Policy zur Zugriffsbeschränkung auf CloudFront OAI und Zugriff über VPC Endpoint
resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Zugriff für CloudFront über Origin Access Identity
      {
        Effect    = "Allow"
        Principal = {
          AWS = var.oai_iam_arn
        }
        Action    = ["s3:GetObject", "s3:ListBucket"]
        Resource  = [
          "${aws_s3_bucket.s3_bucket.arn}",
          "${aws_s3_bucket.s3_bucket.arn}/*"
        ]
      },
      # Zugriff über VPC Endpoint
      {
        Effect = "Allow"
        Principal = "*"
        Action = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        Resource = [
          "${aws_s3_bucket.s3_bucket.arn}",
          "${aws_s3_bucket.s3_bucket.arn}/*"
        ]
        Condition = {
          StringEquals = {
            "aws:SourceVpce" = var.s3_vpc_endpoint_id
          }
        }
      }
    ]
  })
}


