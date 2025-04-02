terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "custom_nginx" {
  name = "nginx:latest"
}

resource "docker_container" "web" {
  name  = "my-nginx"
  image = docker_image.custom_nginx.image_id

  ports {
    internal = 80
    external = 8080
  }
  mounts {
    type   = "bind"
    target = "/usr/share/nginx/html"

    # The path.cwd objects lets you retrieve the
    # Terraform configuration's current working directory
    # as Docker bind mounts requires an absolute path
    source = "${path.cwd}/website"
  }
}
