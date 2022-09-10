#Reserving Public IP
resource "azurerm_public_ip" "pub" {
  name                = "pub-ip"
  depends_on = [
   azurerm_subnet.subnet,
   azurerm_resource_group.rg
  ]
  resource_group_name = var.rg
  location            = var.location
  allocation_method   = "Dynamic"
}

#Creating Network Interface
resource "azurerm_network_interface" "nic" {

  count = 2

  name                = "teste${count.index}"
  location            = var.location
  resource_group_name = var.rg

  depends_on = [
    azurerm_subnet.subnet
  ]

  ip_configuration {
    name                          = "NIC-Test-Terras"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = "192.168.1.${ 10+count.index}"


  //Associating the public ip to a NIC. The count.index represent's the NIC that will receive the IP, in this case the NIC[0]
    public_ip_address_id = count.index == 0 ? azurerm_public_ip.pub.id : null
  }
}


