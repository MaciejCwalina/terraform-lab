# Lekcja 3: for_each, czyli wiele podobnych zasobów z jednej definicji.
# Zadanie: postaw TRZY kontenery nginx (dev, test, prod), każdy na innym porcie,
# używając JEDNEGO bloku resource "docker_container".

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

# Mapa środowisk: klucz = nazwa środowiska, wartość = port.
variable "environments" {
  type = map(number)
  default = {
    dev  = 8091
    prod = 8093
  }
}


resource "docker_container" "web" {
    for_each = var.environments
    name = "lekcja-3-${each.key}"
    image = docker_image.nginx.image_id
    ports {
      internal = 80
      external = each.value
    }
}  

output "urls" {
  value = {for name,port in var.environments : name => "http://localhost:${port}"}
}


# TODO 1: jeden zasób, który utworzy kontener dla każdego wpisu w var.environments.
#
#   resource "docker_container" "web" {
#     for_each = var.environments
#     name     = "lekcja-3-${each.key}"      # each.key   -> "dev", "test", "prod"
#     image    = ...
#     ports {
#       internal = 80
#       external = ...                       # each.value -> 8091, 8092, 8093
#     }
#   }

# TODO 2 (outputs.tf albo tutaj): output "urls" z mapą środowisko -> adres.
#   Podpowiedź (wyrażenie "for"):
#   value = { for name, port in var.environments : name => "http://localhost:${port}" }

# TODO 3: po apply usuń "test" z mapy i zrób terraform plan.
#   Pytanie: ile kontenerów Terraform usunie i dlaczego tylko tyle?
