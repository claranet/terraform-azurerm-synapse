data "azurecaf_name" "adls" {
  name          = var.stack
  resource_type = "azurerm_storage_account"
  clean_input   = true
}

resource "azurerm_storage_account" "adls" {
  name = data.azurecaf_name.adls.result

  resource_group_name      = module.rg.name
  location                 = module.azure_region.location
  is_hns_enabled           = true
  account_replication_type = "LRS"
  account_tier             = "Standard"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "adls_container" {
  name               = "container"
  storage_account_id = azurerm_storage_account.adls.id
}

resource "azurerm_storage_container" "sql_defender" {
  name                  = "synapse-sql-defender"
  storage_account_name  = module.logs.storage_account_name
  container_access_type = "private"
}

module "synapse" {
  source  = "claranet/synapse/azurerm"
  version = "x.x.x"

  resource_group_name = module.rg.name
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  stack               = var.stack
  environment         = var.environment
  client_name         = var.client_name

  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.adls_container.id

  sql_administrator_login    = "Example"
  sql_administrator_password = var.sql_administrator_password

  aad_admin = var.aad_admin

  saas_connection = false

  logs_destinations_ids              = [module.logs.id]
  linking_allowed_for_aad_tenant_ids = []

  sql_defender_container = {
    name                 = azurerm_storage_container.sql_defender.name
    storage_account_name = module.logs.storage_account_name
    resource_group_name  = module.rg.name
  }

  auditing_policy_storage_account = module.logs.storage_account_id

  sql_defender_recurring_scans = {
    enabled                           = true
    email_subscription_admins_enabled = true
    emails                            = ["example@claranet.com"]
  }

  depends_on = [azurerm_storage_container.sql_defender]
}
