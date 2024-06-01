# for minikube
provider "helm" {
    kubernetes {
      config_path = "~/.kube/config"
    }
    }

# for eks AWS
# we can dynamically obtain token to authenticate with cluster

# provider "helm" {
#   kubernetes {
#     host                   = aws_eks_cluster.demo.endpoint
#     cluster_ca_certificate = base64decode(aws_eks_cluster.demo.certificate_authority[0].data)
#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.demo.id]
#       command     = "aws"
#     }
#   }
# }


# AKS provider configuration

# provider "azurerm" {
#   features {}
# }

# resource "azurerm_kubernetes_cluster" "aks" {
#   name                = "exampleaks"
#   location            = "West US"
#   resource_group_name = "example-resources"
#   dns_prefix          = "exampleaks"

#   default_node_pool {
#     name       = "default"
#     node_count = 1
#     vm_size    = "Standard_DS2_v2"
#   }

#   identity {
#     type = "SystemAssigned"
#   }
# }

# provider "helm" {
#   kubernetes {
#     host                   = azurerm_kubernetes_cluster.aks.kube_config.0.host
#     client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
#     client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
#     cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
#   }
# }


# GKE provider configuration

# provider "google" {
#   project = "your-gcp-project-id"
#   region  = "us-central1"
# }

# resource "google_container_cluster" "primary" {
#   name     = "example-gke"
#   location = "us-central1"

#   node_config {
#     machine_type = "e2-medium"
#   }

#   initial_node_count = 1
# }

# provider "helm" {
#   kubernetes {
#     host                   = google_container_cluster.primary.endpoint
#     cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
#     client_certificate     = base64decode(google_container_cluster.primary.master_auth.0.client_certificate)
#     client_key             = base64decode(google_container_cluster.primary.master_auth.0.client_key)
#   }
# }
