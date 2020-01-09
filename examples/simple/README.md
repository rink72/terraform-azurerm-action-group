# Simple Alert Group example

Configuration in this directory creates a test resource group and then deploys a single alert group in to it.

It will configure two webhook receivers and two email receivers.

This also demonstrates the usage of the `ag_depends_on` variable.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.