resource "azurerm_network_interface_security_group_association" "nic_assoc" {
  network_interface_id      = data.azurerm_network_interface.nic-data.id
  network_security_group_id = data.azurerm_network_security_group.nsg-data.id
}
