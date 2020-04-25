variable "region" {
  default = "us-central1"
}

variable "location" {
  default = "us-central1"
}

variable "cluster_name" {}

variable "machine_type" {
  default = "n1-standard-1"
}

variable "initial_node_count" {
  default = 2
}

variable "TFC_WORKSPACE_NAME" {}
