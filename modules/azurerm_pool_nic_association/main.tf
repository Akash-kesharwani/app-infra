resource "azurerm_network_interface_backend_address_pool_association" "nic-pool" {
  network_interface_id    = data.azurerm_network_interface.nic-data.id
  ip_configuration_name   = var.nic_config_name
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.pool-data.id
}