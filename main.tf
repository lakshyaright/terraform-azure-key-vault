resource "azurerm_key_vault" "keyvault" {
    for_each = var.keyvaults
  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  rbac_authorization_enabled  = true
  enabled_for_disk_encryption = false
  tenant_id                   = each.value.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

resource "azurerm_key_vault_secret" "keyvault_secret" {
  for_each = var.keyvaults
  name         = each.value.secret_name
  value        = each.value.value
  key_vault_id = azurerm_key_vault.keyvault[each.key].id
}