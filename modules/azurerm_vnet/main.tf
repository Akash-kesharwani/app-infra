
resource "azurerm_virtual_network" "example" {
  name                = var.vnet-name
  location            = var.location
  resource_group_name = var.rg-name
  address_space       = ["10.0.0.0/16"]
  
}