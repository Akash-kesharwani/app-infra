data "azurerm_subnet" "bas-subnet-data" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = var.vnet-name
  resource_group_name  = var.rg-name
}
