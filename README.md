vpc terraform module
===========

A terraform module to provide a VPC in AWS.


Module Input Variables
----------------------

- `name` - vpc name
- `cidr` - vpc cidr
- `public_subnets` - list of public subnet cidrs
- `private_subnets` - list of private subnet cidrs
- `azs` - list of AZs in which to distribute subnets
- `enable_dns_hostnames` - should be true if you want to use private DNS within the VPC
- `enable_dns_support` - should be true if you want to use private DNS within the VPC
- `private_propagating_vgws` - list of VGWs the private route table should propagate
- `public_propagating_vgws` - list of VGWs the public route table should propagate

It's generally preferable to keep `public_subnets`, `private_subnets`, and
`azs` to lists of the same length.

Usage
-----

```hcl
module "vpc" {
  source = "github.com/terraform-community-modules/tf_aws_vpc"

  name = "my-vpc"

  cidr = "10.0.0.0/16"
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  azs      = ["us-west-2a", "us-west-2b", "us-west-2c"]
}
```

For Terraform version older than 0.7.0 use `ref=v1.0.0`:
`source = "github.com/terraform-community-modules/tf_aws_vpc?ref=v1.0.0"`

Outputs
=======

 - `vpc_id` - does what it says on the tin
 - `private_subnets` - list of private subnet ids
 - `public_subnets` - list of public subnet ids
 - `public_route_table_id` - public route table id string
 - `private_route_table_id` - private route table id string

Authors
=======

Originally created and maintained by [Casey Ransom](https://github.com/cransom)
Hijacked by [Paul Hinze](https://github.com/phinze)

License
=======

Apache 2 Licensed. See LICENSE for full details.
