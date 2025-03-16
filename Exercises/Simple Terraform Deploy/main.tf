terraform {
  required_version = ">= 1.11.1"
  # TODO add the kreuzwerker/docker provider here
}

resource "docker_image" "caddyv2" {
  # TODO add the docker image caddy:2 here
}

resource "docker_container" "caddyv2" {
  # TODO add the container name, and reference
  # the downloaded image from teh docker_image.caddyv2 resource
  ports {
    internal = 80
    external = 8000
  }
}