terraform {
  required_version = ">= 1.11.1"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

resource "docker_image" "mariadb" {
  name = "mariadb:11"
  keep_locally = true
}

resource "docker_container" "mariadb" {
  image = docker_image.mariadb.image_id
  name = var.db_hostname
  ports {
    internal = 3306
    external = 3306
  }
  env = [
    "MARIADB_DATABASE=laravel_quickstart",
    "MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=true",
    "MARIADB_USER=laravel",
    "MARIADB_PASSWORD=${var.db_password}"
  ]
  networks_advanced {
    name = var.docker_network
  }
}
