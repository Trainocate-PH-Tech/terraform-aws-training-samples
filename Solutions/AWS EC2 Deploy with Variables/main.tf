terraform {
  required_version = "~> 1.11"
  required_providers {
    aws = {
      source = "aws"
      version = "~> 5.93"
    }
  }
}

module "ec2_instance" {
  source        = "./modules/ec2_instance"
  ami_id        = var.ami_id
  instance_type = var.instance_type
}
