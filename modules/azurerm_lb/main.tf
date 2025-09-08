resource "azurerm_lb" "lb" {
  name                = var.lb-name
  location            = var.location
  resource_group_name = var.rg-name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = data.azurerm_public_ip.pip-data.id
  }
}
resource "azurerm_lb_backend_address_pool" "pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = var.pool-name
}

resource "azurerm_lb_rule" "rule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = var.lb-rule-name
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids =[ azurerm_lb_backend_address_pool.pool.id ]
  probe_id = azurerm_lb_probe.probe.id
}

resource "azurerm_lb_probe" "probe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = var.probe-name
  port            = 80
}