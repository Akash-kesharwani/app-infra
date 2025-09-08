data "azurerm_lb" "lb-data" {
  name                = var.lb-name
  resource_group_name = var.rg-name
}

data "azurerm_lb_backend_address_pool" "pool-data" {
  name            = var.pool-name
  loadbalancer_id = data.azurerm_lb.lb-data.id
}

data "azurerm_network_interface" "nic-data" {
  name                = var.nic-name
  resource_group_name = var.rg-name
}