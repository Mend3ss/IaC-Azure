resource "azurerm_network_interface" "nic-win-server" {
  name                = "example-nic"
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

resource "azurerm_public_ip" "example" {
  name                = "Pub-IP-Win-Server"
  resource_group_name = var.rg
  location            = var.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}