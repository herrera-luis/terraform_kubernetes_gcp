
resource "google_container_registry" "registry" {
  project                 = var.project_id
  location                = "US"
}


resource "google_cloudbuild_trigger" "trigger" {
  project                   = var.project_id
  provider                  = google-beta
  name                      = "${var.environment_id}-trigger"
  description               = "pipeline that will be triggered if repository is updated"
  github   {
    owner                   = var.repository_owner
    name                    = var.repository_name
    push {
        branch              = "^${var.branch_name}$"
    }
  }
   substitutions = {
    _NAMESPACE              = var.environment_id
    _CLUSTER                = var.cluster_name
    _REGION                 = var.region
  }
  filename                  = "infrastructure/pipeline/${var.environment_id}"
}