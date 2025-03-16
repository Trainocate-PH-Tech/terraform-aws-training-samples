terraform {
  required_version = ">= 1.11.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }

  # configure S3 remote state backend
  # on applying a remote state, remember to run terraform init
  # docs: https://developer.hashicorp.com/terraform/language/backend/s3
  backend "s3" {
    bucket = "trainocate-terraform-demo-states"
    # change the key name to a unique one
    key    = "aws-ec2-simple/state"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region                   = "ap-southeast-1"
  shared_credentials_files = ["~/.aws/credentials"]
  shared_config_files      = ["~/.aws/config"]
}

# launch ubuntu 24.04 AMI on t2.micro instance
resource "aws_instance" "ubuntu" {
  ami           = "ami-01938df366ac2d954"
  instance_type = "t2.micro"
  tags = {
    # change the name value to a unique one
    Name = "my-terraform-ami-deploy"
  }
}
