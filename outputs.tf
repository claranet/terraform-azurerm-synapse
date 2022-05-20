output "resource_group_name" {
  description = "Azure Resource Group name"
  value       = var.resource_group_name
}

output "location" {
  description = "Azure region"
  value       = var.location
}

output "stack" {
  description = "Application name"
  value       = var.stack
}

output "environment" {
  description = "Application environment"
  value       = var.environment
}

output "tags" {
  description = "Tags set on resources"
  value       = merge(local.default_tags, var.extra_tags)
}

output "id" {
  description = "Synapse ID"
  value       = azurerm_synapse_workspace.synapse.id
}

output "name" {
  description = "Synapse name"
  value       = azurerm_synapse_workspace.synapse.name
}

output "connectivity_endpoints" {
  description = "A list of connectivity endpoints for this Synapse Workspace."
  value       = azurerm_synapse_workspace.synapse.connectivity_endpoints
}
