provider "helm" {
  kubernetes {
    host                   = "https://${google_container_cluster.primary.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
    load_config_file       = false
  }
}

data "google_client_config" "default" {}

data "helm_repository" "incubator" {
  name = "incubator"
  url  = "https://migara.github.io/sock-shop-demo"
}

output "name" {
  value = data.helm_repository.incubator.metadata[0].name
}

# resource "helm_release" "my_cache" {
#   name       = "my-cache"
#   repository = data.helm_repository.incubator.metadata[0].name
#   chart      = "redis-cache"
# }
