locals {
  managed_resource_group_name = coalesce(var.managed_resource_group_name, data.azurecaf_name.rg.result)
}
