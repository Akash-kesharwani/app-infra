data "azurerm_network_interface" "nic-data" {
  name                = var.nic-name
  resource_group_name = var.rg-name
}

data "azurerm_network_security_group" "nsg-data" {
  name                = var.nsg-name
  resource_group_name = var.rg-name
}