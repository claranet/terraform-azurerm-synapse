data "azurecaf_name" "synapse" {
  name          = var.stack
  resource_type = "azurerm_synapse_workspace"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "synapse"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "rg" {
  name          = var.stack
  resource_type = "azurerm_resource_group"
  prefixes      = compact(["syws", var.name_prefix == "" ? null : local.name_prefix])
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "synapse"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}
