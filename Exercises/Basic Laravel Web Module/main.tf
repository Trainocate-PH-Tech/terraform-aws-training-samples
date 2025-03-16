terraform {
  required_version = ">= 1.11.1"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }
}

# provider-specific defaults
# any module using the AWS provider will have this
# provider configuration, except it will be overriden
# at the module level
provider "aws" {
  region                   = "ap-southeast-1"
  shared_credentials_files = ["~/.aws/credentials"]
  shared_config_files      = ["~/.aws/config"]
}

# web module for laravel
# pass variables from root variables.tf file to
# the module's variables.tf file
#
# additionally, the docker network configuration will come
# from the net module below
module "web" {
  # TODO complete the inputs
  docker_network = module.net.docker_network
}

# db module for mariadb
module "db" {
  # TODO complete the inputs
  docker_network = module.net.docker_network
}

# docker network module
# only need the source here since this module
# only returns an output defined in this module's
# outputs.tf file
module "net" {
  # TODO complete the inputs
}
