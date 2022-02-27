resource "digitalocean_project" "kubernetes" {
  name        = "Testing Demo ${var.project_version}"
  description = "${var.project_name} ${var.project_version}"
  resources   = [
    "do:kubernetes:${digitalocean_kubernetes_cluster.kubernetes_cluster.id}"
  ]

  depends_on = [
    digitalocean_kubernetes_cluster.kubernetes_cluster
  ]
}
