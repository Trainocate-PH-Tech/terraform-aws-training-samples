# AWS Private ECR + ECS Deployment template

This deployment template allows you to scaffold the following:

* A ECS cluster without any service deployment
* A private ECR registry, ready to accept images to be pushed

## Objective

The ECR configuration is already built, but the ECS configuration is still missing the service deployment and the task definition assignment. Additionally, the root module is intentionally left incomplete.

Your objective are as follows:

* Add the missing requirements on the root module
* Output the value of the ECR Repository URI
* Create an ECS service with the following requirements ([documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service#network_configuration)):
  * Use the cluster that will be generated from the configuration
  * Use the task definition from the `ecs_task_definition_name`'s default value (this task definition will run `caddy:2` pulled from ECR Public Gallery)
  * Launch type is `FARGATE`
  * Desired count is 1
  * Auto-assign a public IP to this service
  * One more pre-requisite step to properly deploy this service