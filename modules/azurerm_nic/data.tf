data "azurerm_subnet" "subnet-data" {
  name                 = var.subnet-name
  virtual_network_name = var.vnet-name
  resource_group_name  = var.rg-name
}