provider "azurerm" {
  version = ">= 1.39.0"
}

locals {
  location = "australiasoutheast"
  name     = "testingag"

  action_group_definitions = {
    ag-test1 = {
      short_name = "ag-test1"
      enabled    = true
      webhook_definitions = [
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
    }
  }
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

  resource_group_name = "${local.name}-${random_integer.id.result}"

  action_group_definitions = local.action_group_definitions

  ag_depends_on = [
    module.resource-group
  ]
}
