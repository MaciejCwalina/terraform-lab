# Lekcja 4: moduły. Ten plik (root module) tylko UŻYWA modułu z ./modules/web.

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


   module "blog" {
     source  = "./modules/web"
     name    = "lekcja-4-blog"
     port    = 8101
     message = "To jest blog"
   }

   module "shop" {
     source  = "./modules/web"
     name    = "lekcja-4-sklep"
     port    = 8102
     message = "To jest sklep"
   }

# TODO 3: output "url" z adresem strony.
output urls {
    value = {
        blog = module.blog.urls
        shop = module.shop.urls
    }
    
}

# TODO 4: wywołaj moduł dwa razy:
#
#   module "blog" {
#     source  = "./modules/web"
#     name    = "lekcja-4-blog"
#     port    = 8101
#     message = "To jest blog"
#   }
#
#   module "shop" { ... port 8102, inny message ... }
#
# TODO 5: output "urls" w tym pliku, który zbiera module.blog.url i module.shop.url.
#   Wyjście modułu czytasz tak: module.<nazwa>.<output>
#
# Po każdej zmianie w modułach: terraform init (żeby Terraform zobaczył nowe moduły), potem plan/apply.
