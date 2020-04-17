variable "project" {
  default = ""
}

variable "region" {
  default = "us-central1"
}

variable "location" {
  default = "us-central1-a"
}

variable "instance_id" {
  default = "01"
}

variable "cluster_name" {
  default = "student-${var.instance_id}-cluster"
}

variable "node_pool" {
  default = "student-${var.instance_id}-node-pool"
}

variable "machine_type" {
  default = "n1-standard-1"
}
