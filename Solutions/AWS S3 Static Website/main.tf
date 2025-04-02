terraform {
  required_version = "~> 1.11"
  required_providers {
    aws = {
      source  = "aws"
      version = "~> 5.90"
    }
  }
}

module "s3_bucket" {
  source      = "./modules/s3_static_site"
  bucket_name = var.bucket_name
}
