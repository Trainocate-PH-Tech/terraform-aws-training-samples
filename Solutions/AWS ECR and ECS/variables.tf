variable "ecs_cluster_name" {
  type = string
  description = "The name of your ECS cluster"
  default = "my-ecs-cluster"
  nullable = false
}

variable "ecs_service_name" {
  type = string
  description = "The name of the ECS service to deploy"
  default = "my-ecs-service"
  nullable = false
}

variable "ecs_task_definition_name" {
  type = string
  description = "The task definition to deploy to the ECS service"
  default = "trainocate-demo-caddy"
  nullable = false
}

variable "ecr_name" {
  type = string
  description = "The name of your private ECR repository"
  default = "demos/my-ecr-repository"
  nullable = false
}

variable "ecr_scan_on_push" {
  type = bool
  description = "Enable basic image scanning on image push"
  default = false
}