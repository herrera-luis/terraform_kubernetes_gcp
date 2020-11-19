provider "google" {
  version                           = "~> 3.47"
  project                           = var.gcp_project_id
  region                            = local.region_type
}

provider "google-beta" {
  version                           = "~> 3.47"
  project                           = var.gcp_project_id
  region                            = local.region_type
}

module "network" {
  source                            = "./infrastructure/network"
  name                              = local.network_name
  region                            = local.region_type
  ip_cidr_range_subnet              = local.ip_cidr_range_subnet
}

module "kubernetes" {
  source                            = "./infrastructure/kubernetes"
  name                              = local.kubernetes_name
  namespace_id                      = local.env
  project_id                        = var.gcp_project_id
  region                            = local.region_type
  gke_num_nodes                     = local.kubernetes_nodes_num
  issue_client_certificate          = local.kubernetes_issue_client_certificate
  machine_type                      = local.kubernetes_machine_type
  preemptible                       = local.kubernetes_preemptible_option
  google_compute_network_vpc        = module.network.google_compute_network_vpc
  google_compute_subnetwork_subnet  = module.network.google_compute_subnetwork_subnet
}

module "gcloud_kubectl-wrapper" {
  source                            = "terraform-google-modules/gcloud/google//modules/kubectl-wrapper"
  version                           = "2.0.2"
  module_depends_on                 = [module.kubernetes.namespace_id]
  project_id                        = var.gcp_project_id
  cluster_name                      = module.kubernetes.kubernetes_cluster_name
  cluster_location                  = local.region_type
  kubectl_create_command            = "kubectl apply -f ${local.manifest_path} -n ${local.env}"
  kubectl_destroy_command           = "kubectl delete -f ${local.manifest_path} -n ${local.env}"
}

module "pipeline" {
  source                            = "./infrastructure/pipeline"
  project_id                        = var.gcp_project_id
  environment_id                    = local.env
  region                            = local.region_type
  cluster_name                      = module.kubernetes.kubernetes_cluster_name
  branch_name                       = local.branch_name
  repository_owner                  = local.repository_owner
  repository_name                   = local.repository_name
}