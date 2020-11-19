
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


resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
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


provider "kubernetes" {
  version = "~> 1.13.3"
  host = "https://${google_container_cluster.primary.endpoint}"
  username = google_container_cluster.primary.master_auth.0.username
  password = google_container_cluster.primary.master_auth.0.password
  client_certificate = base64decode(google_container_cluster.primary.master_auth.0.client_certificate)
  client_key = base64decode(google_container_cluster.primary.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

resource "kubernetes_namespace" "namespace" {
  depends_on = [google_container_node_pool.primary_nodes]
  metadata {
    name = var.namespace_id
  }
}

resource "google_container_registry" "registry" {
  project                 = var.project_id
  location                = "US"
}