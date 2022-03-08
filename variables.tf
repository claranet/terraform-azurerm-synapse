variable "location" {
  description = "Azure location."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "stack" {
  description = "Project stack name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "storage_data_lake_gen2_filesystem_id" {
  description = "Azure Data Lake Gen 2 resource id"
  type        = string
}

variable "sql_administrator_login" {
  description = "Administrator login of synapse sql database"
  type        = string
}

variable "sql_administrator_password" {
  description = "Administrator password of synapse sql database"
  type        = string
}

variable "aad_admin" {
  description = "Credentials of the Azure AD Administrator of this Synapse Workspace."
  type = object({
    login     = string
    tenant_id = string
    object_id = string
  })
  default = {
    login     = ""
    tenant_id = ""
    object_id = ""
  }
}

variable "saas_connection" {
  description = "Used to configure Public Network Access"
  type        = bool
  default     = false
}

variable "sql_defender_container" {
  description = "A blob storage container path to hold the scan results and all Threat Detection audit logs."
  type = object({
    name                 = string
    storage_account_name = string
    resource_group_name  = string
  })
}

variable "sql_defender_recurring_scans" {
  description = "SQL defender scan configuration"
  type = object({
    enabled                           = bool
    email_subscription_admins_enabled = bool
    emails                            = list(string)
  })
  default = null
}

variable "auditing_policy_storage_account" {
  description = "ID of SQL audit policy storage account"
  type        = string
}

variable "linking_allowed_for_aad_tenant_ids" {
  description = "Allowed Aad Tenant Ids For Linking"
  type        = list(string)
  default     = []
}


variable "compute_subnet_id" {
  description = "Subnet ID used for computes in workspace"
  type        = string
  default     = null
}

variable "data_exfiltration_protection_enabled" {
  description = "Is data exfiltration protection enabled in this workspace ?"
  type        = bool
  default     = false
}

variable "purview_id" {
  description = "The ID of purview account."
  type        = string
  default     = null
}

variable "sql_identity_control_enabled" {
  description = "Are pipelines (running as workspace's system assigned identity) allowed to access SQL pools?"
  type        = bool
  default     = false
}

variable "managed_resource_group_name" {
  description = "Workspace managed resource group name"
  type        = string
  default     = null
}

variable "azure_devops_configuration" {
  description = "Azure Devops repo Configuration"
  type = object({
    account_name    = string
    branch_name     = string
    last_commit_id  = optional(string)
    project_name    = string
    repository_name = string
    root_folder     = string
    tenant_id       = string
  })
  default = null
}

variable "customer_managed_key" {
  description = "A customer_managed_key block supports the following: key_versionless_id - (Required) The Azure Key Vault Key Versionless ID to be used as the Customer Managed Key (CMK) for double encryption. key_name - (Optional) An identifier for the key. Name needs to match the name of the key used with the azurerm_synapse_workspace_key resource. Defaults to \"cmk\" if not specified."
  type = object({
    key_versionless_id = string
    key_name           = optional(string)
  })
  default = null
}

variable "retention_days" {
  description = "Number of days for retention of security policies"
  type        = number
  default     = 30
}
