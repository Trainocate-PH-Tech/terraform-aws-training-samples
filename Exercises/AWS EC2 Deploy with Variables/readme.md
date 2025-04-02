# EC2 Deployment with Variables & Outputs

## Introduction

This exercise focuses on deploying an EC2 instance using Terraform, leveraging variables for configuration flexibility and outputs for useful information retrieval.

---

## 1. Project Structure

Organize your Terraform project as follows:

```
terraform-ec2-instance/
│── modules/
│   ├── ec2_instance/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│── main.tf
│── outputs.tf
│── variables.tf
│── providers.tf
```

---

## 2. Define the EC2 Module

Inside `modules/ec2_instance/`, create the necessary Terraform files.

### `modules/ec2_instance/main.tf`
Define the resources for:
- Launching an EC2 instance using a variable for the AMI ID.
- Setting up instance type using a variable.

```hcl
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "Terraform-EC2-Instance"
  }
}
```

### `modules/ec2_instance/variables.tf`
Define input variables for the AMI ID and instance type.

```hcl
variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}
```

### `modules/ec2_instance/outputs.tf`
Define the output variable for the EC2 instance public IP.

```hcl
output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}
```

---

## 3. Define the Root Module

Configure `main.tf` at the root level to use the module.

### `main.tf`
```hcl
module "ec2_instance" {
  source        = "./modules/ec2_instance"
  ami_id        = var.ami_id
  instance_type = var.instance_type
}
```

### `variables.tf`
```hcl
variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0abcdef1234567890" # Replace with a valid AMI ID
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}
```

### `outputs.tf`
```hcl
output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = module.ec2_instance.instance_public_ip
}
```

### `providers.tf`
Set up the required AWS provider.

```hcl
provider "aws" {
  region = "us-east-1"
}
```

---

## 4. Running Terraform

Execute the following commands to initialize and apply your Terraform configuration:

```sh
terraform init
terraform apply -auto-approve
```

After deployment, retrieve the EC2 instance's public IP:

```sh
echo $(terraform output instance_public_ip)
```
