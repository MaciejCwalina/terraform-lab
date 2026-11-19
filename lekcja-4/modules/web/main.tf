# Moduł "web": jeden kontener nginx z własną stroną. To jest "funkcja" Terraforma:
# wejście = zmienne, wyjście = outputy, w środku zasoby.

# Moduł też musi powiedzieć, skąd jest provider. Bez tego Terraform założy "hashicorp/docker",
# który nie istnieje, i init się wysypie.
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true # kilka modułów korzysta z tego samego obrazu; nie kasuj go przy destroy
}

# TODO 1: zasób docker_container "this" (w modułach zasób często nazywa się "this").
#   - name: var.name
#   - image: obraz z góry
#   - ports: internal 80, external var.port
#   - upload { ... } wrzuca plik do kontenera. Użyj go, żeby podmienić stronę nginx:
#       upload {
#         content = "<h1>${var.message}</h1>"
#         file    = "/usr/share/nginx/html/index.html"
#       }

resource "docker_container" "this" {
  name = var.name
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = var.port
  }

  upload {
    content = "<h1>${var.message}</h1>"
    file = "/usr/share/nginx/html/index.html"
  }
}

