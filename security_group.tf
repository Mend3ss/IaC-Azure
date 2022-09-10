#Creating Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg
  location            = var.location
  depends_on = [
    azurerm_resource_group.rg
  ]
  resource_group_name = var.rg

  security_rule {
    name                       = "SSH-MyIP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "189.62.47.222"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH-AnyIP"
    priority                   = 205
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name = "HTTP"
    priority = 210
    direction = "Inbound"
    access = "Deny"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "80"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}

#Associating the Subnet with Security Group
resource "azurerm_subnet_network_security_group_association" "subnsg" {
  subnet_id = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}