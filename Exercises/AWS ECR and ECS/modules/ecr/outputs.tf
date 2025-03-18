output "ecr_repository_uri" {
  description = "The generated URI for your private ECR"
  value = aws_ecr_repository.private_ecr.repository_url
}