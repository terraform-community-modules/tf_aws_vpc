vpc terraform module
===========

A terraform module to provide a VPC in AWS.


Module Input Variables
----------------------

- `name` - vpc name
- `cidr` - vpc cidr
- `public_subnets` - comma separated list of public subnet cidrs
- `private_subnets` - - comma separated list of private subnet cidrs
- `azs` - comma separated lists of AZs in which to distribute subnets
- `enable_dns_hostnames` - A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false.

It's generally preferable to keep `public_subnets`, `private_subnets`, and
`azs` to lists of the same length.

Usage
-----

```js
module "vpc" {
  source = "github.com/terraform-community-modules/tf_aws_vpc"

  name = "my-vpc"

  cidr = "10.0.0.0/16"
  private_subnets = "10.0.1.0/24,10.0.2.0/24,10.0.3.0/24"
  public_subnets  = "10.0.101.0/24,10.0.102.0/24,10.0.103.0/24"

  azs      = "us-west-2a,us-west-2b,us-west-2c"

  enable_dns_hostnames = true
}
```

Outputs
=======

 - `vpc_id` - does what it says on the tin
 - `private_subnets` - comma separated list of private subnet ids
 - `public_subnets` - comma separated list of public subnet ids

Authors
=======

Originally created and maintained by [Casey Ransom](https://github.com/cransom)
Hijacked by [Paul Hinze](https://github.com/phinze)

License
=======

Apache 2 Licensed. See LICENSE for full details.
