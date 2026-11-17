output "account_id" {
  description = "Azure Resource Manager ID of the Video Indexer account"
  value       = azapi_resource.account.id
}

output "account_name" {
  description = "Name of the Video Indexer account"
  value       = azapi_resource.account.name
}

output "principal_id" {
  description = "System-assigned managed identity principal ID"
  value       = azapi_resource.account.output.identity.principalId
}

output "data_plane_account_id" {
  description = "Video Indexer data-plane account ID"
  value       = azapi_resource.account.output.properties.accountId
}
