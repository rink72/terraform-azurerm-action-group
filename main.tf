terraform {
  required_version = ">= 0.12.0"
}

# A special variable used to pass in dependencies to the module
variable "ag_depends_on" {
  type        = any
  description = "A special variable used to pass in dependencies to the module"
  default     = null
}

resource "azurerm_monitor_action_group" "action_group" {

  name                = var.name
  resource_group_name = var.resource_group_name
  short_name          = var.short_name
  enabled             = var.enabled


  dynamic "webhook_receiver" {
    for_each = [for wh in var.webhook_definitions : {
      name                    = wh.name
      service_uri             = wh.service_uri
      use_common_alert_schema = wh.use_common_alert_schema
    }]

    content {
      name                    = webhook_receiver.value.name
      service_uri             = webhook_receiver.value.service_uri
      use_common_alert_schema = webhook_receiver.value.use_common_alert_schema
    }
  }

  dynamic "email_receiver" {
    for_each = [for e in var.email_definitions : {
      name                    = e.name
      email_address           = e.email_address
      use_common_alert_schema = e.use_common_alert_schema
    }]

    content {
      name                    = email_receiver.value.name
      email_address           = email_receiver.value.email_address
      use_common_alert_schema = email_receiver.value.use_common_alert_schema
    }
  }

  tags = var.tags

  # Check if there are any dependencies required
  depends_on = [
    var.ag_depends_on
  ]
}
