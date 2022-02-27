resource "helm_release" "external_dns" {
  name             = "${terraform.workspace}-externaldns"
  namespace        = "external-dns"
  create_namespace = true
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "external-dns"
  version          = "5.0.0"
  depends_on       = [
    digitalocean_kubernetes_cluster.kubernetes_cluster
  ]

#  set {
#    name  = "provider"
#    value = "cloudflare"
#  }

#  set {
#    name  = "sources"
#    value = "{ingress}"
#  }

  # If it's set to upsert-only records will be created by DNS but never deleted
#  set {
#    name  = "policy"
#    value = "sync" #upsert-only
#  }
#
#  set {
#    name  = "registry"
#    value = "txt"
#  }

#  set {
#    name  = "txtOwnerId"
#    value = terraform.workspace
#  }

  #  set {
  #     name  = "txtPrefix"
  #     value = terraform.workspace
  #   }

  set {
    name  = "domainFilters"
    value = "{foo.chiangmars.com}"
  }
}

