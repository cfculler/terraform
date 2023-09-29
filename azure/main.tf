resource "azurerm_resource_group" "rg" {
  name     = "carson-terraform-dob"
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
    owner = "carson"
  }
}

resource "azurerm_storage_container" "sc" {
  name                  = "carson-dob"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
