variable "resource_group_name" {
  type        = string
  description = "The name of the resource group to deploy the alert group in to."
}

variable "name" {
  type        = string
  description = "The name of the alert group."
}

variable "short_name" {
  type        = string
  description = "The short name to use for the alert group. Max 12 characters."
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the storage account and solutions."
  default     = {}
}

variable "enabled" {
  type        = bool
  description = "Should the action group be enabled."
  default     = true
}

variable "webhook_definitions" {
  description = "A list of webhook configurations."
  default     = []
}

variable "email_definitions" {
  description = "A list of email configurations."
  default     = []
}
