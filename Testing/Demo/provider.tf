terraform {
  required_version = ">= 1.0.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.10.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.5.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }

  backend "s3" {
    endpoint                    = "https://fra1.digitaloceanspaces.com"
    bucket                      = "testing-space-1"
    key                         = "terraform.tfstate"
    region                      = "eu-west-1"
    skip_credentials_validation = true
    profile                     = "testing-digitalocean"
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "helm" {
  kubernetes {
    host                   = digitalocean_kubernetes_cluster.kubernetes_cluster.endpoint
    cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.kubernetes_cluster.kube_config[0].cluster_ca_certificate
    )
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = [
        "kubernetes", "cluster", "kubeconfig", "exec-credential",
        "--version=v1beta1", digitalocean_kubernetes_cluster.kubernetes_cluster.id
      ]
      command     = "doctl"
    }
  }
}

provider "kubernetes" {
  host                   = digitalocean_kubernetes_cluster.kubernetes_cluster.endpoint
  token                  = digitalocean_kubernetes_cluster.kubernetes_cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(
  digitalocean_kubernetes_cluster.kubernetes_cluster.kube_config[0].cluster_ca_certificate
  )
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "doctl"
    args        = [
      "kubernetes", "cluster", "kubeconfig", "exec-credential",
      "--version=v1beta1", digitalocean_kubernetes_cluster.kubernetes_cluster.id
    ]
  }
}
