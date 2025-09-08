resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion-name
  location            = var.location
  resource_group_name = var.rg-name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.subnet-data.id
    public_ip_address_id = data.azurerm_public_ip.pip-data.id
  }
}