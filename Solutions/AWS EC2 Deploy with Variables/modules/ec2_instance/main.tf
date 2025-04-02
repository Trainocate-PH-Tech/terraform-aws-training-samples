terraform {
  required_version = "~> 1.11"
  required_providers {
    aws = {
      source = "aws"
      version = "~> 5.93"
    }
  }
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "Terraform-EC2-Instance"
  }
}
