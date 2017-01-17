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
- `enable_nat_gateway` - should be true if you want to provision NAT Gateways for each of your private networks
- `map_public_ip_on_launch` - should be false if you do not want to auto-assign public IP on launch
- `private_propagating_vgws` - list of VGWs the private route table should propagate
- `public_propagating_vgws` - list of VGWs the public route table should propagate
- `tags` - dictionary of tags that will be added to resources created by the module

It's generally preferable to keep `public_subnets`, `private_subnets`, and
`azs` to lists of the same length.

This module optionally creates NAT Gateways in each public subnet and sets them
as the default gateways for the corresponding private subnets.

Usage
-----

```hcl
module "vpc" {
  source = "github.com/terraform-community-modules/tf_aws_vpc"

  name = "my-vpc"

  cidr = "10.0.0.0/16"
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = "true"

  azs      = ["us-west-2a", "us-west-2b", "us-west-2c"]

  tags {
    "Terraform" = "true"
    "Environment" = "${var.environment}"
  }
}
```

For Terraform version older than 0.7.0 use `ref=v1.0.0`:
`source = "github.com/terraform-community-modules/tf_aws_vpc?ref=v1.0.0"`

Outputs
=======

 - `vpc_id` - does what it says on the tin
 - `private_subnets` - list of private subnet ids
 - `public_subnets` - list of public subnet ids
 - `public_route_table_ids` - list of public route table ids
 - `private_route_table_ids` - list of private route table ids
 - `default_security_group_id` - VPC default security group id string
 - `nat_eips` - list of Elastic IP ids (if any are provisioned)
 - `igw_id` - Internet Gateway id string

**NOTE**: previous versions of this module returned a single string as a route
table ID, while this version returns a list.

Authors
=======

Originally created and maintained by [Casey Ransom](https://github.com/cransom)
Hijacked by [Paul Hinze](https://github.com/phinze)

License
=======

Apache 2 Licensed. See LICENSE for full details.
