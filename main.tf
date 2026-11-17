terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

resource "random_string" "account_suffix" {
  length  = 6
  lower   = true
  upper   = false
  numeric = true
  special = false
}

locals {
  account_name = "vi-${var.environment}-${random_string.account_suffix.result}"
}

resource "azapi_resource" "account" {
  type      = "Microsoft.VideoIndexer/accounts@2025-04-01"
  name      = local.account_name
  parent_id = var.resource_group_id
  location  = var.location

  body = {
    identity = {
      type = "SystemAssigned"
    }
    properties = {
      publicNetworkAccess = var.public_network_access
      storageServices = {
        resourceId           = var.storage_account_id
        userAssignedIdentity = ""
      }
    }
    tags = var.tags
  }

  response_export_values = [
    "identity.principalId",
    "properties.accountId",
  ]
}

resource "azurerm_role_assignment" "storage_blob_data_contributor" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azapi_resource.account.output.identity.principalId
  principal_type       = "ServicePrincipal"
}
