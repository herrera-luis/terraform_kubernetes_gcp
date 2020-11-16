output "kubernetes_cluster_primary" {
  value       = google_container_cluster.primary
  description = "GKE Cluster primary"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "GKE Cluster Name"
}

output "cluster_ca_certificate" {
  value     = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
  sensitive = true
}

output "client_certificate" {
  description = "The bearer token for auth"
  sensitive   = true
  value       = base64encode(google_container_cluster.primary.master_auth.0.client_certificate)
}

output "client_key" {
  description = "The bearer token for auth"
  sensitive   = true
  value       = base64encode(google_container_cluster.primary.master_auth[0].client_key)
}

output "namespace_id" {
  description = "the namespace_id"
  value       = kubernetes_namespace.namespace.metadata[0].name
}
