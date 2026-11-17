# Azure AI Video Indexer module

Creates an Azure AI Video Indexer account using the Microsoft.VideoIndexer ARM resource API, associates the existing platform storage account, enables a system-assigned managed identity, and grants that identity `Storage Blob Data Contributor` on the storage account.

This is a reusable **child module**: the caller supplies the resource group and storage account IDs, while this module manages the Video Indexer account and its storage role assignment. A minimal caller is provided in [`examples/video-indexer`](../../../../examples/video-indexer/README.md).

## Inputs

| Name | Required | Description |
| --- | --- | --- |
| `environment` | Yes | `dev`, `uat`, or `prod`; included in the generated account name |
| `location` | Yes | Azure region |
| `resource_group_id` | Yes | Resource group ID for the Video Indexer account |
| `storage_account_id` | Yes | Storage account resource ID associated with the account |
| `public_network_access` | No | `Enabled` or `Disabled`; defaults to `Enabled` |
| `tags` | No | Resource tags |

The generated account name has the form `vi-<environment>-<random-suffix>`. The suffix is retained in Terraform state to keep the name stable.

## Outputs

- `account_id`: ARM resource ID
- `account_name`: generated resource name
- `principal_id`: system-assigned managed identity principal ID
- `data_plane_account_id`: account ID returned by the Video Indexer ARM API

## Provider note

AzureRM does not currently expose this resource as a dedicated resource, so this module uses the official AzAPI provider with `Microsoft.VideoIndexer/accounts@2025-04-01`. The Azure Video Indexer ARM API reference documents the account resource, identity, public network access, and storage service properties.

References:

- [Microsoft.VideoIndexer/accounts REST API](https://learn.microsoft.com/en-us/rest/api/videoindexer/accounts/create-or-update?view=rest-videoindexer-2025-04-01)
- [Terraform AzAPI provider overview](https://learn.microsoft.com/en-us/azure/developer/terraform/overview-azapi-provider)

## Network note

The default keeps public network access enabled for service access. Set `public_network_access = "Disabled"` only after the required private connectivity is configured and verified for your environment.
