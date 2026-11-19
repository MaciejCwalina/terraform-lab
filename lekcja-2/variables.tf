# TODO 1: zdefiniuj dwie zmienne. Składnia:
#
#   variable "nazwa" {
#     type        = string        # albo number, bool, list(string)...
#     default     = "wartość"     # opcjonalnie; bez default Terraform zapyta o wartość
#     description = "Do czego służy"
#   }
#
# a) container_name: string, domyślnie "terraform-lekcja-2"
# b) external_port:  number, domyślnie 8080
#
# Bonus: dodaj do external_port blok validation, który odrzuci porty poniżej 1024:
#   validation {
#     condition     = <warunek na var.external_port>
#     error_message = "Port musi być >= 1024."
#   }


variable "container_name" {
    type = string
    default = "nasz-kontener"
    description = "value"
}

variable "external_port" {
  type = number
  default = 8080
  description = "external port for ngnix"
  validation {
    condition = var.external_port >= 1024 && var.external_port < 65000
    error_message = "port musi byc >= 1024"
  }
}
