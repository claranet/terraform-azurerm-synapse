variable "azure_region" {
  description = "Azure region to use."
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming."
  type        = string
}

variable "environment" {
  description = "Project environment."
  type        = string
}

variable "stack" {
  description = "Project stack name."
  type        = string
}

variable "sql_administrator_password" {
  description = "SQL admin password."
  type        = string
}

variable "aad_admin" {
  description = "Credentials of the Azure AD Administrator."
  type = object({
    login     = string
    tenant_id = string
    object_id = string
  })
}
