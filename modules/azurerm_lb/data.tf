data "azurerm_public_ip" "pip-data" {
  name                = var.pip-name
  resource_group_name = var.rg-name
}