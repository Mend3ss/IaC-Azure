resource "azurerm_windows_virtual_machine" "Win-Server-Lab" {
  name                = "example-machine"
  resource_group_name = var.rg
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "Pikachu"
  admin_password      = "Thunder@132"
  network_interface_ids = [
    azurerm_network_interface.nic-win-server.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}