resource "azurerm_public_ip" "bas-pip" {
  name                = var.bas-pip-name
  resource_group_name = var.rg-name
  location            = var.location
  allocation_method   = "Static"

}

resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion-name
  location            = var.location
  resource_group_name = var.rg-name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.bas-subnet-data.id
    public_ip_address_id = azurerm_public_ip.bas-pip.id
  }
}