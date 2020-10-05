resource "kubernetes_namespace" "infrastructure" {
  metadata {
    name = "infrastructure"
  }
}

resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "3.4.0"
  namespace  = "infrastructure"

  values     = ["${file("files/values.yaml")}"]
  depends_on = [kubernetes_namespace.infrastructure]
}