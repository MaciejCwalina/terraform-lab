# Lekcja 7: remote state i blokady (locking).
#
# Do tej pory state był w pliku terraform.tfstate obok kodu. W zespole to nie działa:
#   - kolega nie ma twojego pliku, więc jego Terraform myśli, że nic nie istnieje,
#   - dwie osoby robiące apply naraz mogą zepsuć state.
# Dlatego state trzyma się w "backendzie": Azure Storage, S3, Terraform Cloud... albo Postgres.
# Tu użyjemy Postgresa w Dockerze, bo jest za darmo i lokalnie.
#
# KROK 0 (terminal): baza na state
#   docker run -d --name tf-state-db -e POSTGRES_PASSWORD=lab -p 5433:5432 postgres:17
#   export PG_CONN_STR="postgres://postgres:lab@localhost:5433/postgres?sslmode=disable"
#
# (Hasło "lab" jest tylko do ćwiczenia. W prawdziwym projekcie connection string idzie ze zmiennej
#  środowiskowej albo z Key Vaulta, nigdy z kodu. Dlatego tu też nie ma go w pliku.)

terraform {
  # TODO 1: dodaj backend Postgres. Bez argumentów: adres bierze z PG_CONN_STR.
  backend "pg" {}

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
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "web" {
  name  = "lekcja-7"
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = 8120
  }
}



# TODO 2: terraform init, potem terraform apply.
#   Sprawdź: w katalogu NIE ma terraform.tfstate. Gdzie jest state?
#   docker exec -it tf-state-db psql -U postgres -c "select name from terraform_remote_state.states;"
#
# TODO 3: blokada. Otwórz DWA terminale w tym katalogu (w obu export PG_CONN_STR=...).
#   W pierwszym: terraform apply  (NIE wpisuj yes, zostaw pytanie otwarte)
#   W drugim:    terraform plan
#   Co się stanie w drugim i dlaczego?
#
# TODO 4: terraform destroy, potem: docker rm -f tf-state-db
