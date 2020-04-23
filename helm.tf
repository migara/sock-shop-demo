provider "helm" {
  kubernetes {
    host                   = "https://${google_container_cluster.primary.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
    load_config_file       = false
  }
}

data "google_client_config" "default" {}

resource "helm_release" "local" {
  name  = "hipster-shop"
  chart = "./hipster-shop"

  timeout = 1800
}
