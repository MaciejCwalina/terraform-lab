# Lekcja 6: import, czyli przejęcie zasobu, który ktoś wcześniej "wyklikał" ręcznie.
#
# Sytuacja z życia: w firmie ktoś postawił coś w portalu Azure/New Relic ręcznie, a wy chcecie
# zarządzać tym Terraformem. Nie kasujecie i nie stawiacie od nowa, tylko IMPORTUJECIE do state.
#
# KROK 0 (w terminalu): postaw kontener RĘCZNIE, bez Terraforma:
#   docker run -d --name reczny-nginx -p 8110:80 nginx:latest
#
# Teraz Terraform nic o nim nie wie: nie ma go w kodzie ani w state.

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

# KROK 1: blok import mówi Terraformowi: "zasób o tym ID już istnieje, przypisz go do tego adresu w kodzie".
#   id = ID kontenera z: docker inspect --format '{{.Id}}' reczny-nginx
#
# TODO 1: odkomentuj i wstaw ID.
import {
   to = docker_container.reczny
   id = "570853c192239ffbbadacd7a11b63e36ffbe9bfe7e7e035908d9d5d6041ea184"
 }

# KROK 2: Terraform potrafi SAM napisać kod dla importowanego zasobu:
#   terraform plan -generate-config-out=generated.tf
# Otwórz generated.tf i zobacz, co wygenerował.
#
# TODO 2: zrób terraform apply. Plan powinien pokazać "1 to import, 0 to add, 0 to change, 0 to destroy".
#         Jeśli pokazuje "to change" albo "forces replacement", to wygenerowany kod różni się od rzeczywistości.
#
# TODO 3: zmień coś w kodzie (np. dodaj label albo zmień restart na "unless-stopped") i zrób plan.
#         Pytanie: czy Terraform podmieni kontener, czy zmieni go w miejscu?
#
# TODO 4: terraform destroy. Kontener, który postawiłeś RĘCZNIE, zniknie, bo teraz należy do Terraforma.
