terraform {
  required_version = ">= 0.12"

  required_providers {
    azurerm = "=3.0.0"
  }

}


#Declarating cloud provider
provider "azurerm" {
  features {}
}


#Creating Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.rg
  location = var.location
}


#Creating Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet
  depends_on = [
    azurerm_resource_group.rg
  ]
  resource_group_name = var.rg
  location            = var.location
  address_space       = ["192.168.0.0/16"]
}


#Creating Subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet
  resource_group_name  = var.rg

 depends_on = [
   azurerm_virtual_network.vnet
 ]

  virtual_network_name = var.vnet
  address_prefixes     = ["192.168.1.0/24"]
}


# #Creating ssh-key
# resource "azurerm_ssh_public_key" "name" {
# name = "pub-key"
# depends_on = [
#   azurerm_resource_group.rg
# ]
# resource_group_name = var.rg
# location = var.location
# public_key = file("terraform-azure.pub")
# }
