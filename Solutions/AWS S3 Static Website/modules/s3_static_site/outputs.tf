output "aws_bucket_website_endpoint" {
  value = data.aws_s3_bucket.bucket_info.website_endpoint
}
