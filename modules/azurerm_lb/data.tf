data "azurerm_public_ip" "pip-data" {
  name                = var.subnet-name
  resource_group_name = var.rg-name
}