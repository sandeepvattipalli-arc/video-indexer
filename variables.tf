variable "environment" {
  description = "Deployment environment used to name the account"
  type        = string

  validation {
    condition     = contains(["dev", "uat", "prod"], var.environment)
    error_message = "environment must be one of: dev, uat, prod."
  }
}

variable "location" {
  description = "Azure region for the Video Indexer account"
  type        = string
}

variable "resource_group_id" {
  description = "Resource group ID in which the Video Indexer account will be created"
  type        = string
}

variable "storage_account_id" {
  description = "Storage account resource ID associated with the Video Indexer account"
  type        = string
}

variable "public_network_access" {
  description = "Whether public network access is enabled for the account"
  type        = string
  default     = "Enabled"

  validation {
    condition     = contains(["Enabled", "Disabled"], var.public_network_access)
    error_message = "public_network_access must be Enabled or Disabled."
  }
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
