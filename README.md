vpc terraform module
===========

A terraform module to provide a VPC in AWS.


Module Input Variables
----------------------
(Inputs for the modules we're using)

*aws provider*
- `aws_access_key`
- `aws_secret_key`
- `aws_region`
- `environment_name`
- `cidr_block`
- `dns_support`
- `dns_hostnames`

Usage
-----

To use this template, you need to do the following:

1.) Setting values for the following variables, either through `terraform.tfvars` or `-var` arguments on the CLI

- `aws_access_key`
- `aws_secret_key`
- `aws_region`
- `environment_name`
- `cidr_block`
- `dns_support`
- `dns_hostnames`

2.) Assuming you've created a `terraform.tfvars` file, then you'll use `terraform get` to pull in your module dependences and run a `terraform plan` execution to see if your input variables will result in the AWS resources you wanted.

```
terraform get -update
terraform plan -var-file terraform.tfvars -no-color -module-depth=-1
```

3.) Assuming the output of the plan looks good to you, you apply with with

```
terraform apply
```

Authors
=======

Created and maintained by [Casey Ransom](https://github.com/cransom)

License
=======

Apache 2 Licensed. See LICENSE for full details.
