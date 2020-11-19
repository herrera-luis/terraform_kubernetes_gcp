locals {
  env                       = terraform.workspace
  region = {
    "dev"                   = "us-central1"
    "stg"                   = "us-central1"
    "prod"                  = "us-central1"
  }
  network_name              = "network-${local.env}"
  ip_cidr_ranges            = {
    "dev"                   = "10.10.0.0/24"
    "stg"                   = "10.20.0.0/24"
    "prod"                  = "10.30.0.0/24"
  }
  kubernetes_name           = "k8s-${local.env}"
  kubernetes_nodes          = {
    "dev"                   = "1"
    "stg"                   = "1"
    "prod"                  = "2"
  }
  kubernetes_client_certificate        = {
    "dev"                   = false
    "stg"                   = true
    "prod"                  = true
  }
  kubernetes_machine        = {
    "dev"                   = "n1-standard-1"
    "stg"                   = "n1-standard-2"
    "prod"                  = "n1-standard-2"
  }
  kubernetes_preemptible    = {
    "dev"                   = true
    "stg"                   = true
    "prod"                  = false
  }
   branch_names    = {
    "dev"                   = "main"
    "stg"                   = "stg"
    "prod"                  = "prod"
  }
  
  manifest_path             = "./infrastructure/app"
  repository_owner          = "herrera-luis"
  repository_name           = "terraform_kubernetes_gcp"
  ip_cidr_range_subnet      = lookup(local.ip_cidr_ranges,local.env)
  branch_name               = lookup(local.branch_names,local.env)
  region_type               = lookup(local.region,local.env)
  kubernetes_nodes_num      = lookup(local.kubernetes_nodes,local.env)
  kubernetes_issue_client_certificate = lookup(local.kubernetes_client_certificate,local.env)
  kubernetes_machine_type = lookup(local.kubernetes_machine,local.env)
  kubernetes_preemptible_option = lookup(local.kubernetes_preemptible,local.env)
}
