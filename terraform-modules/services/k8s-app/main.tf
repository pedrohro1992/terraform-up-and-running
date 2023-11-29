terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}
locals {
  pod_labels = {
    app = var.name
  }
  status = kubernetes_service.app.status
}

resource "kubernetes_deployment" "app" {
  metadata {
    name = var.name
  }
  spec {
    replicas = var.replicas

    template {
      metadata {
        labels = local.pod_labels
      }
      spec {
        container {
          name  = var.name
          image = var.image

          port {
            container_port = var.containet_port
          }

          dynamic "env" {
            for_each = var.environment_variables
            content {
              name  = env.key
              value = env.value
            }
          }
        }
      }
    }
    selector {
      match_labels = local.pod_labels
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = var.name
  }
  spec {
    type = var.create_lb_eks ? "LoadBalancer" : "ClusterIP"
    port {
      port        = 80
      target_port = var.containet_port
      protocol    = "TCP"
    }
    selector = local.pod_labels
  }
}

output "service_endpoint" {
  value = try(
    "http://${local.status[0]["load_balancer"][0]["ingress"][0]["hostname"]}",
    "(error parsing hostname from status)"
  )
  description = "The K8S Service Endpoint"
}
