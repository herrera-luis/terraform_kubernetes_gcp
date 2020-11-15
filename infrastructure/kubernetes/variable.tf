variable "name" {
  description = "name id for resources"
  type        = string
}

variable "namespace_id" {
  description = "namespace_id"
  type        = string
}

variable "region" {
  description = "region id"
  type        = string
}

variable "issue_client_certificate" {
  description = "issue client certificate"
  type        = bool
}

variable "machine_type" {
  description = "machine type id"
  type        = string
}

variable "preemptible" {
  description = "preemptible"
  type        = bool
}

variable "gke_num_nodes" {
  description = "number of gke nodes"
  type        = number
}

variable "gke_username" {
  description = "gke username"
  type        = string
}

variable "gke_password" {
  description = "gke password"
  type        = string
}

variable "google_compute_network_vpc" {
  description = "network vpc"
}

variable "google_compute_subnetwork_subnet" {
  description = "network subnet"
}




