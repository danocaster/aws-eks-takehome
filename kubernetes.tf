resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "nginx"
  }
  depends_on = [
    module.eks_cluster.eks_managed_node_groups
  ]
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.nginx.metadata.0.name
  }
  spec {
    replicas = var.ngninx_replicas
    selector {
      match_labels = {
        app = "nginx"
      }
    }
    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }
      spec {
        container {
          image = "nginx"
          name  = "nginx"
          port {
            container_port = 80
          }
          port {
            container_port = 443
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress" "nginx_http" {
  metadata {
    name = "nginx-http"
  }
  spec {
    backend {
      service_name = "nginx"
      service_port = 80
    }
  }
}

resource "kubernetes_ingress" "nginx_https" {
  metadata {
    name = "nginx-https"
  }
  spec {
    backend {
      service_name = "nginx"
      service_port = 443
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.nginx.metadata.0.name
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type"            = "external"
      "service.beta.kubernetes.io/aws-load-balancer-nlb-target-type" = "ip"
      "service.beta.kubernetes.io/aws-load-balancer-scheme"          = "internet-facing"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment.nginx.spec.0.template.0.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    type             = "LoadBalancer"
    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }
    port {
      port        = 443
      target_port = 443
      protocol    = "TCP"
    }
  }
}