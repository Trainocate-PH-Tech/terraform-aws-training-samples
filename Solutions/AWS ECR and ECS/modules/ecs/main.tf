terraform {
  required_version = ">= 1.11.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }
}

data "aws_subnets" "default_vpc_subnets" {
  filter {
    name = "vpc-id"
    values = ["vpc-c8837aae"]
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

resource "aws_ecs_service" "demo_service" {
  name = "demo-ecs-service"
  cluster = aws_ecs_cluster.demo_cluster.id
  task_definition = data.aws_ecs_task_definition.demo_taskdef.arn
  launch_type = "FARGATE"
  desired_count = 1
  network_configuration {
    subnets = data.aws_subnets.default_vpc_subnets.ids
    assign_public_ip = true
  }
}
