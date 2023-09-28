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
    subscription_id      = "3e16852e-8399-4c16-b246-16bf46bc3747"
    tenant_id            = "1b4a4fed-fed8-4823-a8a0-3d5cea83d122"
    client_id            = "e886df3c-c276-43de-a390-d1cdc6d69e57" 
  }
}

variable "client_secret" {}

provider "azurerm" {
  features {}

  client_id       = "e886df3c-c276-43de-a390-d1cdc6d69e57"
  client_secret   = var.client_secret
  tenant_id       = "1b4a4fed-fed8-4823-a8a0-3d5cea83d122"
  subscription_id = "3e16852e-8399-4c16-b246-16bf46bc3747"
}