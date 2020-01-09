provider "azurerm" {
  version = ">= 1.39.0"
}

locals {
  location = "australiasoutheast"
  name     = "testingag"

  webhooks = [
    {
      name                    = "testwh"
      service_uri             = "http://test"
      use_common_alert_schema = true
    },
    {
      name                    = "testwh2"
      service_uri             = "http://test2"
      use_common_alert_schema = false
    }
  ]

  emails = [
    {
      name                    = "email1"
      email_address           = "test1@email.com"
      use_common_alert_schema = true
    },
    {
      name                    = "email2"
      email_address           = "test2@email.com"
      use_common_alert_schema = false
    }
  ]
}

# Get a random integer to provide a unique Log Analytics workspace name as they are globally unique
resource "random_integer" "id" {
  min = 10000
  max = 50000
}

# Create a resource group to deploy the log analytics workspace to
module "resource-group" {
  source  = "rink72/resource-group/azurerm"
  version = "1.0.0"

  name     = "${local.name}-${random_integer.id.result}"
  location = local.location
}

# Create the automation account in the created resource group.
module "alert-group" {
  source = "../../"

  name                = "${local.name}${random_integer.id.result}"
  resource_group_name = "${local.name}-${random_integer.id.result}"
  short_name          = local.name

  webhook_definitions = local.webhooks
  email_definitions   = local.emails

  ag_depends_on = [
    module.resource-group
  ]
}
