resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "this" {
  name       = var.release_name
  repository = var.chart_repository
  chart      = var.chart_name
  version    = var.chart_version
  namespace  = kubernetes_namespace.this.metadata[0].name

  # Merge any override values as YAML
  values = [
    yamlencode(var.values_override)
  ]

  # Sensible defaults for local dev
  wait             = true
  timeout          = 300
  cleanup_on_fail  = true
  atomic           = true
}

resource "kubernetes_ingress_v1" "grafana" {
  metadata {
    name      = "grafana-ingress"
    namespace = kubernetes_namespace.this.metadata[0].name
    annotations = {
      "nginx.org/rewrites"                          = "serviceName=prometheus-grafana rewrite=/"
      "nginx.ingress.kubernetes.io/force-ssl-redirect" = "false"
      "cert-manager.io/cluster-issuer"              = "letsencrypt-prod"
    }
  }

  spec {
    ingress_class_name = "nginx"

    tls {
      hosts       = ["grafana.kinexa.co.uk"]
      secret_name = "grafana-tls"
    }

    rule {
      host = "grafana.kinexa.co.uk"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "prometheus-grafana"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }

  depends_on = [helm_release.this]
}