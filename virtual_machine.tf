#Creating Virtual Machine
resource "azurerm_virtual_machine" "vm" {

//The count is the number of VM's that you need. The name of vm will start with 0
  count = 2

  name = "teste${count.index}"
  location              = var.location

  depends_on = [
    azurerm_resource_group.rg
  ]
  
  resource_group_name   = var.rg
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  vm_size               = var.img

  tags = {
    name = "teste${count.index}"
  }

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true


  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "My-Disk${count.index}-Terras"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "Mend3ss"
    admin_username = "Pikachu"
    admin_password = "P1k4P1k4"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
