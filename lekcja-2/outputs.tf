# TODO 3: output wyświetla wartość po apply (i jest widoczny dla innych modułów).
#
#   output "nazwa" {
#     value = <wyrażenie>
#   }
#
# a) url: adres strony, np. "http://localhost:8080"
#    Podpowiedź: interpolacja napisów w HCL wygląda tak: "http://localhost:${var.external_port}"
# b) container_id: ID kontenera, docker_container.web.id


output "url" {
  value = "http://localhost:${var.external_port}"
}

output "container_id" {
  value = "${docker_image.nginx.image_id}" 
}