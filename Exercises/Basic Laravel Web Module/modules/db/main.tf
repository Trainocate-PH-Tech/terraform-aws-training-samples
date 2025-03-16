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
  # TODO complete the inputs
}

resource "docker_container" "mariadb" {
  # TODO complete the input
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
