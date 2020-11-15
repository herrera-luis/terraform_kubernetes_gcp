locals {
  env                       = terraform.workspace
  region = {
    "dev"                   = "us-central1"
    "prod"                  = "us-central1"
  }
  network_name              = "network-${local.env}"
  kubernetes_name           = "k8s-${local.env}"
  kubernetes_nodes          = {
    "dev"                   = "1"
    "prod"                  = "1"
  }
  kubernetes_client_certificate        = {
    "dev"                   = false
    "prod"                  = true
  }
  kubernetes_machine        = {
    "dev"                   = "n1-standard-1"
    "prod"                  = "n1-standard-2"
  }
  kubernetes_preemptible    = {
    "dev"                   = true
    "prod"                  = false
  }
  manifests_path   = {
    "dev"                   = "./infrastructure/app/dev"
    "prod"                  = "./infrastructure/app/prod"
  }
  branch_name               = "main"
  repository_owner          = "herrera-luis"
  repository_name           = "terraform_kubernetes_gcp"
  manifest_path             = lookup(local.manifests_path,local.env)
  region_type               = lookup(local.region,local.env)
  kubernetes_nodes_num      = lookup(local.kubernetes_nodes,local.env)
  kubernetes_issue_client_certificate = lookup(local.kubernetes_client_certificate,local.env)
  kubernetes_machine_type = lookup(local.kubernetes_machine,local.env)
  kubernetes_preemptible_option = lookup(local.kubernetes_preemptible,local.env)
}
