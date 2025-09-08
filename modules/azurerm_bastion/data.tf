
data "azurerm_subnet" "subnet-data" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = var.vnet-name
  resource_group_name  = var.rg-name
}

data "azurerm_public_ip" "pip-data" {
  name                = var.pip-name
  resource_group_name = var.rg-name
}