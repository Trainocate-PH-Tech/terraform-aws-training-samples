terraform {
  required_version = ">= 1.11.1"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

resource "docker_network" "laravelnet" {
  name = "laravelnet"
}
