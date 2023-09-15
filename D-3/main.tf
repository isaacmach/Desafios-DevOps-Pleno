terraform {
  required_providers {
    azurerm = {
      source  = "hashicor/azurerm"
      version = "=2.46.0" 
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "isaac_k8s" {
  name     = "isaac_k8s"
  location = "brazilsouth"
}

resource "azurerm_kubernetes_cluster" "isaac" {
  name                = "cluster_isaac"
  location            = azurerm_resource_group.isaac_k8s.location
  resource_group_name = azurerm_resource_group.isaac_k8s.name
  dns_prefix          = "isaac-cluster"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "testing"
  }
}
