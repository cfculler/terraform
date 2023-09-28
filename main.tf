# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"

  backend "azurerm" {
    resource_group_name  = "carson-terraform-dob"
    storage_account_name = "carsonterraformstorage"
    container_name       = "carson-dob"
    key                  = "prod.terraform.carson-dob"
    use_oidc             = true
    subscription_id      = ""
    tenant_id            = ""
    client_id            = ""
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "westus2"
  tags = {
    Environment = "Terraform Getting Started"
    Team = "DevOps"
  }
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "carson-terraform-dob-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "westus2"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_storage_account" "sa" {
  name                     = "carsonterraformstorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "sc" {
  name                  = "carson-dob"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
