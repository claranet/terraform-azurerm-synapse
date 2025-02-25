output "resource" {
  description = "Synaps Workspace resource object."
  value       = azurerm_synapse_workspace.main
}

output "id" {
  description = "Synapse ID."
  value       = azurerm_synapse_workspace.main.id
}

output "name" {
  description = "Synapse name."
  value       = azurerm_synapse_workspace.main.name
}

output "connectivity_endpoints" {
  description = "A list of connectivity endpoints for this Synapse Workspace."
  value       = azurerm_synapse_workspace.main.connectivity_endpoints
}

output "security_alert_policy" {
  description = "Security Alert Policy for this Synapse Workspace."
  value       = azurerm_synapse_workspace_security_alert_policy.main
}

output "vulnerability_assessment" {
  description = "Vulnerability Assessment for this Synapse Workspace."
  value       = azurerm_synapse_workspace_vulnerability_assessment.main
}

output "auditing_policy" {
  description = "Extended Auditing Policy for this Synapse Workspace."
  value       = azurerm_synapse_workspace_extended_auditing_policy.main
}

output "resource_group_name" {
  description = "Azure Resource Group name."
  value       = var.resource_group_name
}

output "location" {
  description = "Azure region."
  value       = var.location
}

output "stack" {
  description = "Application name."
  value       = var.stack
}

output "environment" {
  description = "Application environment."
  value       = var.environment
}

output "tags" {
  description = "Tags set on resources."
  value       = merge(local.default_tags, var.extra_tags)
}

output "module_diagnostics" {
  description = "Diagnostics settings module outputs."
  value       = module.diagnostics
}
