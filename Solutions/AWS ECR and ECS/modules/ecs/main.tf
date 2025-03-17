terraform {
  required_version = ">= 1.11.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }
}

data "aws_ecs_task_definition" "demo_taskdef" {
  task_definition = var.ecs_task_definition_name
}

# provide ECS cluster
resource "aws_ecs_cluster" "demo_cluster" {
  name = var.ecs_cluster_name

  setting {
    name = "containerInsights"
    value = "disabled"
  }
}