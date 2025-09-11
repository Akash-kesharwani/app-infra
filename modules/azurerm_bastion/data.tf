
data "azurerm_subnet" "bas-subnet-data" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = var.vnet-name
  resource_group_name  = var.rg-name
}

data "azurerm_public_ip" "bas-pip-data" {
  name                = var.bas-pip-name
  resource_group_name = var.rg-name
}