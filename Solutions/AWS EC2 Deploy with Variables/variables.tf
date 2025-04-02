variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-065a492fef70f84b1" # Amazon Linux, x86_64, ap-southeast-1
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}
