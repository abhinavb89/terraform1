resource "azurerm_resource_group" "myrg" {
    ##using the refrence name all the resource value are mapped inside your terraform.tfstate file
  name     = "myrg" #resource group name will be unique
  location = "eastus"
}

