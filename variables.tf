variable "project" {}

variable "region" {
  default = "us-central1"
}

variable "location" {
  default = "us-central1"
}

variable "instance_id" {}

variable "cluster_name" {}

variable "node_pool" {}

variable "machine_type" {
  default = "n1-standard-1"
}

variable "initial_node_count" {
  default = 2
}
