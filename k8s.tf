resource "kubernetes_namespace" "infrastructure" {
  metadata {
    name = "infrastructure"
  }
}

resource "kubernetes_secret" "github_argocd_token" {
  type = "kubernetes.io/basic-auth"
  metadata {
    name      = "github-argocd-token"
    namespace = "infrastructure"
  }
  data = {
    username = "volym3ad"
    password = var.github_argocd_token
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "2.8.0"
  namespace  = "infrastructure"

  values = ["${file("helm/argo-cd/values.yaml")}"]
  depends_on = [
    kubernetes_namespace.infrastructure,
    kubernetes_secret.github_argocd_token
  ]
}