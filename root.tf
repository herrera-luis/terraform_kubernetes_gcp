provider "google" {
  project             = "${var.project_id}"
  region              = "${local.region_type}"
  version             = "~> 3.47"
}

module "network" {
  source              = "./infrastructure/network"
  name                = "${local.network_name}"
  region              = "${local.region_type}"
}

module "kubernetes" {
  source                            = "./infrastructure/kubernetes"
  name                              = "${local.kubernetes_name}"
  region                            = "${local.region_type}"
  gke_num_nodes                     = "${local.kubernetes_nodes_num}"
  gke_username                      = "${var.gke_username}"
  gke_password                      = "${var.gke_password}"
  issue_client_certificate          = "${local.kubernetes_issue_client_certificate}"
  machine_type                      = "${local.kubernetes_machine_type}"
  preemptible                       = "${local.kubernetes_preemptible_option}"
  google_compute_network_vpc        = "${module.network.google_compute_network_vpc}"
  google_compute_subnetwork_subnet  = "${module.network.google_compute_subnetwork_subnet}"
}
