terraform {
  required_version = "~> 1.11"
  required_providers {
    aws = {
      source  = "aws"
      version = "~> 5.90"
    }
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_website_configuration" "web_config" {
  bucket = aws_s3_bucket.bucket.id
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_policy" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_acl" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.bucket.arn}/*"
      }
    ]
  })

  depends_on = [
    aws_s3_bucket.bucket,
    aws_s3_bucket_public_access_block.bucket_policy
  ]
}

data "aws_s3_bucket" "bucket_info" {
  bucket = aws_s3_bucket.bucket.id
}
