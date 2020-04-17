provider "google" {
  region = var.region
}

resource "google_container_cluster" "primary" {
  name     = "student-${var.instance_id}-cluster"
  location = var.location

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = true
    }
  }

}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "student-${var.instance_id}-node-pool"
  location   = var.location
  cluster    = google_container_cluster.primary.name
  node_count = 3

  node_config {
    preemptible  = true
    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  autoscaling {
    min_node_count = 3
    max_node_count = 8
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
