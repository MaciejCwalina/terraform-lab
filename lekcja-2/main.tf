# Lekcja 2: zmienne (variables) i wyjścia (outputs).
# Ten sam nginx co w lekcji 1, ale bez wpisanych na sztywno wartości.

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "web" {
  # TODO 2: zamiast wpisanych wartości użyj zmiennych z variables.tf:
  #   var.container_name  oraz  var.external_port
  name  = var.container_name
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = var.external_port
  }
}

