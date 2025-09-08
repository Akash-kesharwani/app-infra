data "azurerm_network_interface" "nic-data" {
  name                = var.nic-name
  resource_group_name = var.rg-name
}

data "azurerm_key_vault" "key-vault" {
  name                = "key1-test"
  resource_group_name = "rg-test"
}

data "azurerm_key_vault_secret" "username" {
  name         = "susername"
  key_vault_id = data.azurerm_key_vault.key-vault.id
}

data "azurerm_key_vault_secret" "password" {
  name         = "password"
  key_vault_id = data.azurerm_key_vault.key-vault.id
}