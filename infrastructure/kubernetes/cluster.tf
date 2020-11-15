# GKE cluster
resource "google_container_cluster" "primary" {
  name     = var.name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.google_compute_network_vpc.name 
  subnetwork = var.google_compute_subnetwork_subnet.name

  master_auth {
    username = var.gke_username
    password = var.gke_password

    client_certificate_config {
      issue_client_certificate = var.issue_client_certificate
    }
  }
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.name
    }

    preemptible  = var.preemptible
    machine_type = var.machine_type
    tags         = ["gke-node", "${var.name}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
