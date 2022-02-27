variable "do_project" {
  default = "Testing"
}

variable "project_name" {
  default = "testing-demo"
}

variable "project_version" {
  default = "v1"
}

variable "kind_cluster_name" {
  type        = string
  description = "The name of the cluster."
  default     = "testing-helm-ingress-nginx"
}

variable "ingress_nginx_helm_version" {
  type        = string
  description = "The Helm version for the nginx ingress controller."
  default     = "4.0.6"
}

variable "region" {
  default = "fra1"
}

variable "do_token" {
  default     = "09fa688be6e376e329fdbb83c71778a96d321d4c3c6be42b31db981ebeb45ac9"
  description = "DigitalOcean API token"
}
