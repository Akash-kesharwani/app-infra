resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm-name
  resource_group_name             = var.rg-name
  location                        = var.location
  size                            = "Standard_F2"
  admin_username                  = data.azurerm_key_vault_secret.username.value
  admin_password                  = data.azurerm_key_vault_secret.password.value
  disable_password_authentication = false
  network_interface_ids = [
    data.azurerm_network_interface.nic-data.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }
}
