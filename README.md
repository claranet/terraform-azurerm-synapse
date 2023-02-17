# Azure Synapse Terraform module

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/synapse/azurerm/)

This terraform module creates an [Azure Synapse](https://docs.microsoft.com/en-us/azure/synapse-analytics/overview-what-is) with
a [Synapse security alert policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace_security_alert_policy),
a [SQL vulnerability assessment](https://docs.microsoft.com/en-us/azure/azure-sql/database/sql-vulnerability-assessment?tabs=azure-powershell),
a [Synapse extended auditing policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace_extended_auditing_policy)
and activated [Diagnostics Logs](https://docs.microsoft.com/en-us/azure/synapse-analytics/monitoring/how-to-monitor-using-azure-monitor).

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 7.x.x       | 1.3.x             | >= 3.0          |
| >= 6.x.x       | 1.x               | >= 3.0          |
| >= 5.x.x       | 0.15.x            | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

```hcl
module "region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "logs" {
  source  = "claranet/run-common/azurerm//modules/logs"
  version = "x.x.x"

  resource_group_name = module.rg.resource_group_name
  stack               = var.stack
  environment         = var.environment
  client_name         = var.client_name
  location            = module.region.location
  location_short      = module.region.location_short
}

resource "azurecaf_name" "adls" {
  name          = var.stack
  resource_type = "azurerm_storage_account"
  clean_input   = true
}

resource "azurerm_storage_account" "adls" {
  name = azurecaf_name.adls.result

  resource_group_name      = module.rg.resource_group_name
  location                 = module.region.location
  is_hns_enabled           = true
  account_replication_type = "LRS"
  account_tier             = "Standard"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "adls_container" {
  name               = "container"
  storage_account_id = azurerm_storage_account.adls.id
}

resource "azurerm_storage_container" "sql_defender" {
  name                  = "synapse-sql-defender"
  storage_account_name  = module.logs.logs_storage_account_name
  container_access_type = "private"
}

module "synapse" {
  source  = "claranet/synapse/azurerm"
  version = "x.x.x"

  resource_group_name = module.rg.resource_group_name
  location            = module.region.location
  location_short      = module.region.location_short
  stack               = var.stack
  environment         = var.environment
  client_name         = var.client_name

  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.adls_container.id

  sql_administrator_login    = "Example"
  sql_administrator_password = var.sql_administrator_password

  saas_connection = false

  logs_destinations_ids              = [module.logs.log_analytics_workspace_id]
  linking_allowed_for_aad_tenant_ids = []

  sql_defender_container = {
    name                 = azurerm_storage_container.sql_defender.name
    storage_account_name = module.logs.logs_storage_account_name
    resource_group_name  = module.rg.resource_group_name
  }

  auditing_policy_storage_account = module.logs.logs_storage_account_id

  sql_defender_recurring_scans = {
    enabled                           = true
    email_subscription_admins_enabled = true
    emails                            = ["example@fr.clara.net"]
  }

  depends_on = [azurerm_storage_container.sql_defender]
}
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2, >= 1.2.22 |
| azurerm | ~> 3.22 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | 6.2.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_synapse_workspace.synapse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace) | resource |
| [azurerm_synapse_workspace_extended_auditing_policy.synapse_auditing_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace_extended_auditing_policy) | resource |
| [azurerm_synapse_workspace_security_alert_policy.synapse_workspace_security_alert_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace_security_alert_policy) | resource |
| [azurerm_synapse_workspace_vulnerability_assessment.synapse_vulnerability_assessment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace_vulnerability_assessment) | resource |
| [azurecaf_name.rg](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.synapse](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurerm_storage_account.audit_logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.auditing_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_container.vulnerability_assessment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_container) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aad\_admin | Credentials of the Azure AD Administrator of this Synapse Workspace. | <pre>object({<br>    login     = string<br>    tenant_id = string<br>    object_id = string<br>  })</pre> | <pre>{<br>  "login": "",<br>  "object_id": "",<br>  "tenant_id": ""<br>}</pre> | no |
| auditing\_policy\_storage\_account | ID of SQL audit policy storage account | `string` | n/a | yes |
| azure\_devops\_configuration | Azure Devops repo Configuration | <pre>object({<br>    account_name    = string<br>    branch_name     = string<br>    last_commit_id  = optional(string)<br>    project_name    = string<br>    repository_name = string<br>    root_folder     = string<br>    tenant_id       = string<br>  })</pre> | `null` | no |
| client\_name | Client name/account used in naming | `string` | n/a | yes |
| compute\_subnet\_id | Subnet ID used for computes in workspace | `string` | `null` | no |
| custom\_diagnostic\_settings\_name | Custom name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| custom\_name | Custom Azure Synapse name, generated if not set | `string` | `""` | no |
| customer\_managed\_key | A customer\_managed\_key block supports the following: key\_versionless\_id - (Required) The Azure Key Vault Key Versionless ID to be used as the Customer Managed Key (CMK) for double encryption. key\_name - (Optional) An identifier for the key. Name needs to match the name of the key used with the azurerm\_synapse\_workspace\_key resource. Defaults to "cmk" if not specified. | <pre>object({<br>    key_versionless_id = string<br>    key_name           = optional(string)<br>  })</pre> | `null` | no |
| data\_exfiltration\_protection\_enabled | Is data exfiltration protection enabled in this workspace ? | `bool` | `false` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| environment | Project environment | `string` | n/a | yes |
| extra\_tags | Additional tags to associate with your Azure Synapse. | `map(string)` | `{}` | no |
| linking\_allowed\_for\_aad\_tenant\_ids | Allowed Aad Tenant Ids For Linking | `list(string)` | `[]` | no |
| location | Azure location. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br>If you want to specify an Azure EventHub to send logs and metrics to, you need to provide a formated string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the `|` character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| logs\_retention\_days | Number of days to keep logs on storage account. | `number` | `30` | no |
| managed\_resource\_group\_name | Workspace managed resource group name | `string` | `null` | no |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name | `string` | `""` | no |
| purview\_id | The ID of purview account. | `string` | `null` | no |
| resource\_group\_name | Resource group name | `string` | n/a | yes |
| retention\_days | Number of days for retention of security policies | `number` | `30` | no |
| saas\_connection | Used to configure Public Network Access | `bool` | `false` | no |
| sql\_administrator\_login | Administrator login of synapse sql database | `string` | n/a | yes |
| sql\_administrator\_password | Administrator password of synapse sql database | `string` | n/a | yes |
| sql\_defender\_container | A blob storage container path to hold the scan results and all Threat Detection audit logs. | <pre>object({<br>    name                 = string<br>    storage_account_name = string<br>    resource_group_name  = string<br>  })</pre> | n/a | yes |
| sql\_defender\_recurring\_scans | SQL defender scan configuration | <pre>object({<br>    enabled                           = bool<br>    email_subscription_admins_enabled = bool<br>    emails                            = list(string)<br>  })</pre> | `null` | no |
| sql\_identity\_control\_enabled | Are pipelines (running as workspace's system assigned identity) allowed to access SQL pools? | `bool` | `false` | no |
| stack | Project stack name | `string` | n/a | yes |
| storage\_data\_lake\_gen2\_filesystem\_id | Azure Data Lake Gen 2 resource id | `string` | n/a | yes |
| use\_caf\_naming | Use the Azure CAF naming provider to generate default resource name. `custom_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| connectivity\_endpoints | A list of connectivity endpoints for this Synapse Workspace. |
| environment | Application environment |
| id | Synapse ID |
| location | Azure region |
| name | Synapse name |
| resource\_group\_name | Azure Resource Group name |
| stack | Application name |
| tags | Tags set on resources |
<!-- END_TF_DOCS -->
