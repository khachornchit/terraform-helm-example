# Deploy the actual Kubernetes cluster
resource "digitalocean_kubernetes_cluster" "kubernetes_cluster" {
  name           = "${var.project_name}-cluster-${var.project_version}"
  region         = var.region
  # Grab the latest version slug from `doctl kubernetes options versions`
  version        = "1.21.9-do.0"
  tags           = ["${var.project_name}-cluster-${var.project_version}"]

  # This default node pool is mandatory
  node_pool {
    name       = "${var.project_name}-default-pool-${var.project_version}"
    size       = "s-4vcpu-8gb-amd"
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 5
    tags       = ["${var.project_name}-node-pool-${var.project_version}"]
  }
}
