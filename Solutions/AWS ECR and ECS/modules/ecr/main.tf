terraform {
  required_version = ">= 1.11.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }
}

resource "aws_ecr_account_setting" "private_ecr_settings" {
  name = "BASIC_SCAN_TYPE_VERSION"
  value = "AWS_NATIVE"
}

resource "aws_ecr_repository" "private_ecr" {
  name = var.ecr_name
  image_scanning_configuration {
    scan_on_push = var.ecr_scan_on_push
  }
}