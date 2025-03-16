terraform {
  required_version = ">= 1.11.1"
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.91.0"
    }
  }
}

# docker configturation
# if AWS CLI v2 is configured and logged in to ECR,
# get the credentials file from your local disk
#
# this also has a hack that gets the registry's URL to
# match the required registry authentication needed, and to
# allow logging in without hard-coding the registry URL
#
# NOTE: if you're running on windows, change the 
# config_file value to
#
#   C:/Users/<username>/.docker/machine/default/config.json
#
provider "docker" {
  registry_auth {
    config_file = "~/.docker/config.json"
    address = split("/", data.aws_ecr_repository.ecr_private.repository_url)[0]
  }
}

# AWS configuration
#
# NOTE: if you're running on windows, change the following to:
#
#   shared_credentials_files = ["C:\Users\<username>\.aws\credentials"]
#   shared_config_files = ["C:\Users\<username>\.aws\config"]
#
provider "aws" {
  region = "ap-southeast-1"
  shared_credentials_files = [ "~/.aws/credentials" ]
  shared_config_files = [ "~/.aws/config" ]
}

# AWS ECR: get the latest image information from
# private ECR, instead of using docker_image resource
# docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_image
data "aws_ecr_image" "laravel" {
  repository_name = "trainocate-demos/laravel-starter-kit-react"
  image_tag = "12"
}

# AWS ECR: get repository info
# needed to get the repository URL to be able to authenticate
# to private ECR
# docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_repository
data "aws_ecr_repository" "ecr_private" {
  name = "trainocate-demos/laravel-starter-kit-react"
}

# Docker: run container
# docs: https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container
resource "docker_container" "laravel" {
  name = "docker-web"
  image = data.aws_ecr_image.laravel.image_uri

  # hack: if the container fails on startup due to
  # race condition, restart until it successfully
  # connects to DB
  restart = "on-failure"
  ports {
    internal = 8000
    external = var.laravel_pf_port
  }
  env = [
    "DB_CONNECTION=mysql",
    "DB_HOST=${var.db_hostname}",
    "DB_PORT=3306",
    "DB_USERNAME=laravel",
    "DB_PASSWORD=${var.db_password}",
    "DB_DATABASE=laravel_quickstart"
  ]

  # docker network connection
  networks_advanced {
    name = var.docker_network
  }
}
