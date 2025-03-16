terraform {
  required_version = ">= 1.11.1"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

resource "docker_image" "caddyv2" {
  name = "caddy:2"
}

resource "docker_container" "caddyv2" {
  name = "caddy2"
  image = docker_image.caddyv2.image_id
  ports {
    internal = 80
    external = 8000
  }
}