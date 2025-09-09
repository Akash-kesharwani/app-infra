module "rg" {
  source   = "../modules/azurerm_resource_group"
  rg-name  = "rg-aks"
  location = "japan east"
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../modules/azurerm_vnet"
  vnet-name  = "vnet-aks"
  location   = "japan east"
  rg-name    = "rg-aks"
}

module "subnet" {
  depends_on       = [module.vnet]
  source           = "../modules/azurerm_subnet"
  subnet-name      = "subnet-aks"
  vnet-name        = "vnet-aks"
  rg-name          = "rg-aks"
  address_prefixes = ["10.0.1.0/24"] 
}

module "nic1" {
  depends_on  = [module.pip, module.subnet]
  source      = "../modules/azurerm_nic"
  nic-name    = "nic1-aks"
  location    = "japan east"
  subnet-name = "subnet-aks"
  vnet-name   = "vnet-aks"
  rg-name     = "rg-aks"
}

module "nic2" {
  depends_on  = [module.pip, module.subnet]
  source      = "../modules/azurerm_nic"
  nic-name    = "nic2-aks"
  location    = "japan east"
  subnet-name = "subnet-aks"
  vnet-name   = "vnet-aks"
  rg-name     = "rg-aks"
}

module "nsg" {
  depends_on = [module.rg]
  source     = "../modules/azurerm_nsg"
  nsg-name   = "nsg-aks"
  rg-name    = "rg-aks"
  location   = "japan east"
}

module "vm1" {
  depends_on = [module.nic1, module.subnet, module.nsg]
  source     = "../modules/azurerm_vm"
  vm-name    = "vm1-aks"
  rg-name    = "rg-aks"
  nic-name   = "nic1-aks"
  location   = "japan east"
  publisher  = "Canonical"
  offer      = "0001-com-ubuntu-server-focal"
  sku        = "20_04-lts"
}

module "vm2" {
  depends_on = [module.nic2, module.subnet]
  source     = "../modules/azurerm_vm"
  vm-name    = "vm2-aks"
  rg-name    = "rg-aks"
  nic-name   = "nic2-aks"
  location   = "japan east"
  publisher  = "Canonical"
  offer      = "0001-com-ubuntu-server-focal"
  sku        = "20_04-lts"
}

module "pip" {
  depends_on = [module.rg]
  source     = "../modules/azurerm_pip"
  pip-name   = "pip-aks"
  rg-name    = "rg-aks"
  location   = "japan east"
}

module "nic1-pool-association" {
  depends_on      = [module.nic1, module.lb]
  source          = "../modules/azurerm_pool_nic_association"
  lb-name         = "lb-aks"
  rg-name         = "rg-aks"
  pool-name       = "pool-aks"
  nic-name        = "nic1-aks"
  nic_config_name = "internal"
}

module "lb" {
  depends_on   = [module.rg, module.subnet]
  source       = "../modules/azurerm_lb"
  lb-name      = "lb-aks"
  rg-name      = "rg-aks"
  location     = "japan east"
  subnet-name  = "subnet-aks"
  pool-name    = "pool-aks"
  lb-rule-name = "pool-rule-aks"
  probe-name   = "probe-aks"
  pip-name   = "pip-aks"
}
module "nsg-nic1" {
  depends_on = [ module.rg, module.nic1 ]
  source = "../modules/azurerm_nsg_nic_association"
  nsg-name = "nsg-aks"
  rg-name = "rg-aks"
  nic-name = "nic1-aks"
}

module "nsg-nic2" {
  depends_on = [ module.rg, module.nic2 ]
  source = "../modules/azurerm_nsg_nic_association"
  nsg-name = "nsg-aks"
  rg-name = "rg-aks"
  nic-name = "nic2-aks"
}

module "nic2-pool-association" {
  depends_on      = [module.lb, module.nic2]
  source          = "../modules/azurerm_pool_nic_association"
  lb-name         = "lb-aks"
  rg-name         = "rg-aks"
  pool-name       = "pool-aks"
  nic-name        = "nic2-aks"
  nic_config_name = "internal"
}
 
module "subnet-bastion" {
  depends_on = [ module.rg, module.vnet ]
  source = "../modules/azurerm_bastion_subnet"
  rg-name = "rg-aks"
  vnet-name = "vnet-aks"
  address_prefixes = ["10.0.2.0/24"]
}

module "bastion" {
  depends_on = [ module.subnet-bastion, module.pip ]
  source = "../modules/azurerm_bastion"
  rg-name = "rg-aks"
  location = "japan east"
  bastion-name = "bastion"
  vnet-name = "vnet-aks"
  pip-name = "pip-aks"
}