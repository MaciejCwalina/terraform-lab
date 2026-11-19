# TODO 2: trzy zmienne wejściowe modułu:
#   name    (string)  - nazwa kontenera
#   port    (number)  - port na hoście
#   message (string)  - tekst na stronie, domyślnie "Hello from Terraform"
variable "name" {
  type    = string
  default = "docker_nginx"
}

variable "port" {
  type    = number
  default = 8080
  validation {
    condition     = var.port >= 1024 && var.port < 65000
    error_message = "Port must be either greater than 1240 or less than 65000"
  }
}


variable "message" {
  type    = string
  default = "hello world from terraform"

}
