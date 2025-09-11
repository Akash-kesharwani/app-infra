resource "azurerm_public_ip" "bas-pip" {
  name                = var.bas-pip-name
  resource_group_name = var.rg-name
  location            = var.location
  allocation_method   = "Static"

}