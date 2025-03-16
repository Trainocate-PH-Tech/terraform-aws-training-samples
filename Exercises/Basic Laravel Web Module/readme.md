# Basic Laravel + DB Terraform Module

This is a demonstration module that deploys a Laravel 12 Starter Kit application configured with a user login/registration demo and MariaDB with ephemeral storage.

## Pre-requisites:

* Terraform >=1.11.1
* Docker Engine (Linux) or Docker Desktop (Windows)
* Configured AWS CLI v2 and an AWS IAM account

## Structure

This module conforms to Terraform's standard module structure. At the root of this module, you will find the `main.tf`, `outputs.tf`, and `variables.tf` files which consists of your main Terraform configuration, the module's variables, and the output values, respectively.

Under this root module, all child modules can be found in `modules/*` directory, each having their specific purpose. The child modules include `web` for the Laravel front-end, `db` for the database, and `net` for Docker Networking configuration.

```
[root module]
|- modules
| |- web
| | |- main.tf
| | |- variables.tf
| |- db
| | |- main.tf
| | |- variables.tf
| |- net
| | |- main.tf
| | |- outputs.tf
```

The root module contains all the configurations required, including providers and provider-specfic configurations, as well as variables and declared modules.

The `web` module contains the configuration required to deploy a Laravel 12 React Starter Kit in Docker. The image is pulled on AWS ECR, and it is already pre-configured to retrieve the image details as well as pulling the image from ECR and run the container locally.

The `db` module contains the configuration to pull and run the official MariaDB container. The DB data will only persist if the container is running, and the data will reset upon updating your infrastructure with `terraform apply` or `terraform destroy`. On running `terraform apply`, you will be required to enter the DB password for the first time.

The `net` module contains the Docker network configuration required to connect the two containers. It is for simply creating a network similar to `docker network create` and returns the Docker network ID. On the `web` and `db` modules, it is also configured to connect to the created network.

## Objective

Complete the missing inputs on the following files:

* `main.tf`
* `modules/web/main.tf`
* `modules/db/main.tf`