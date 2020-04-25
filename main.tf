provider "google" {
  region = var.region
}

resource "google_container_cluster" "primary" {
  name                      = var.TFC_WORKSPACE_NAME
  location                  = var.location
  initial_node_count        = var.initial_node_count
  default_max_pods_per_node = 20

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/21"
    services_ipv4_cidr_block = "/24"
  }

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = true
    }
  }

  node_config {
    preemptible  = true
    machine_type = var.machine_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      name = "tl-nam-student1"
    }

    tags = ["tl-nam-student1"]
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}

# output "name" {
#   # This may seem redundant with the `name` input, but it serves an important
#   # purpose. Terraform won't establish a dependency graph without this to interpolate on.
#   description = "The name of the cluster master. This output is used for interpolation with node pools, other modules."
#   value       = google_container_cluster.primary.name
# }

# output "master_version" {
#   description = "The Kubernetes master version."
#   value       = google_container_cluster.primary.master_version
# }

# output "endpoint" {
#   description = "The IP address of the cluster master."
#   sensitive   = false
#   value       = google_container_cluster.primary.endpoint
# }

# output "client_certificate" {
#   description = "Public certificate used by clients to authenticate to the cluster endpoint."
#   value       = base64decode(google_container_cluster.primary.master_auth[0].client_certificate)
# }

# output "client_key" {
#   description = "Private key used by clients to authenticate to the cluster endpoint."
#   value       = base64decode(google_container_cluster.primary.master_auth[0].client_key)
# }

# output "cluster_ca_certificate" {
#   description = "The public certificate that is the root of trust for the cluster."
#   value       = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
# }
