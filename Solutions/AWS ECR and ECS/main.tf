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
    key    = "aws-ecs-ecr-module/state"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region                   = "ap-southeast-1"
  shared_credentials_files = ["~/.aws/credentials"]
  shared_config_files      = ["~/.aws/config"]
  default_tags {
    tags = {
      deployer = "terraform/1.11.1"
    }
  }
}

module "ecs" {
  source = "./modules/ecs"
  ecs_cluster_name = var.ecs_cluster_name 
  ecs_service_name = var.ecs_service_name
  ecs_task_definition_name = var.ecs_task_definition_name
}

module "ecr" {
  source = "./modules/ecr"
  ecr_name = var.ecr_name
  ecr_scan_on_push = var.ecr_scan_on_push
}
