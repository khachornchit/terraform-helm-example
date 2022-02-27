resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx-${var.project_name}-${var.project_version}"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = var.ingress_nginx_helm_version

  namespace        = "ingress-nginx-${var.project_name}-${var.project_version}"
  create_namespace = true

  values = [file("manifests/nginx_ingress_values.yaml")]

  depends_on = [
    digitalocean_kubernetes_cluster.kubernetes_cluster
  ]
}

#resource "null_resource" "wait_for_ingress_nginx" {
#  triggers = {
#    key = uuid()
#  }
#
#  provisioner "local-exec" {
#    command = <<EOF
#      printf "\nWaiting for the nginx ingress controller...\n"
#      kubectl wait --namespace ${helm_release.ingress_nginx.namespace} \
#        --for=condition=ready pod \
#        --selector=app.kubernetes.io/component=controller \
#        --timeout=90s
#    EOF
#  }
#
#  depends_on = [helm_release.ingress_nginx]
#}
