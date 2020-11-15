
resource "google_container_registry" "registry" {
  project                 = var.project_id
  location                = "US"
}


resource "google_cloudbuild_trigger" "dev-trigger" {
  project                   = var.project_id
  provider                  = google-beta
  name                      = "dev-trigger"
  description               = "pipeline that will be triggered if branch main is updated"
  github   {
    owner                   = var.repository_owner
    name                    = var.repository_name
    push {
        branch              = "^${var.branch_name}$"
    }
  }
   substitutions = {
    _NAMESPACE              = "dev"
    _CLUSTER                = var.cluster_name
    _REGION                 = var.region
  }
  filename                  = "infrastructure/pipeline/main.yaml"
}