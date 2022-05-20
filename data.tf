data "azurerm_storage_account" "audit_logs" {
  name                = var.sql_defender_container.storage_account_name
  resource_group_name = var.sql_defender_container.resource_group_name
}

data "azurerm_storage_container" "vulnerability_assessment" {
  name                 = var.sql_defender_container.name
  storage_account_name = var.sql_defender_container.storage_account_name
}

data "azurerm_storage_account" "auditing_policy" {
  name                = split("/", var.auditing_policy_storage_account)[8]
  resource_group_name = split("/", var.auditing_policy_storage_account)[4]
}
