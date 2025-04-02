output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = module.ec2_instance.instance_public_ip
}
