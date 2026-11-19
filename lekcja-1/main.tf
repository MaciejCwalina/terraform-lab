# Lekcja 1: pierwszy zasób. Terraform postawi kontener nginx na twoim Dockerze.

# 1. Blok terraform: mówi, jakich "providerów" (wtyczek) potrzebujemy.
#    Provider to tłumacz między Terraformem a konkretną usługą (Azure, AWS, Docker, New Relic...).
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# 2. Konfiguracja providera: gdzie jest Docker. Na Linuksie domyślnie przez ten socket.
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# 3. TWOJA KOLEJ. Napisz dwa zasoby (resource):
#
#    a) obraz:      resource "docker_image" "nginx" { ... }
#       - name = "nginx:latest"
#
#    b) kontener:   resource "docker_container" "web" { ... }
#       - name  = "terraform-lekcja-1"
#       - image = <ID obrazu z punktu a>   <- podpowiedź: docker_image.nginx.image_id
#       - blok ports { internal = 80  external = 8080 }
#
#    Składnia każdego zasobu:
#      resource "<typ>" "<twoja_nazwa>" {
#        argument = "wartość"
#      }




resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "web" {
  name  = "terraform-lekcja-1"
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = 8081
  }
}