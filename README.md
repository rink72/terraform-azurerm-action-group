# terraform-azurerm-action-group
Terraform module to create an action group in Azure

![Terraform Version](https://img.shields.io/badge/Terraform-0.12.6-green.svg)

## Dependencies

This module has a workaround implemented for Terraform not supporting `depends_on` in modules. To use this, use the `ag_depends_on` in the same way you would use `depends_on` when calling the module.
For example usage, please see the examples folder.

## webhook_definitions

This variable should be a list of objects. It has three required parameters `name`, `service_uri` and `use_common_alert_schema`.

Example:

```
[
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
```

## email_definitions

This variable should be a list of objects. It has three required parameters `name`, `email_address` and `use_common_alert_schema`.

Example:

```
[
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
```

## References

Source for module dependency workaround: https://discuss.hashicorp.com/t/tips-howto-implement-module-depends-on-emulation/2305/2
