vpc terraform module
===========

A terraform module to provide a VPC in AWS.


Module Input Variables
----------------------

- `name` - name to be used on all the resources created by the module
- `cidr` - the CIDR block for the VPC
- `instance_tenancy` - tenancy option for instances launched into the VPC
- `public_subnets` - list of public subnet cidrs
- `private_subnets` - list of private subnet cidrs
- `database_subnets` - list of private RDS subnet cidrs
- `elasticache_subnets` - list of private Elasticache subnet cidrs
- `azs` - list of AZs in which to distribute subnets
- `enable_dns_hostnames` - should be true if you want to use private DNS within the VPC
- `enable_dns_support` - should be true if you want to use private DNS within the VPC
- `enable_nat_gateway` - should be true if you want to provision NAT Gateways
- `enable_s3_endpoint` - should be true if you want to provision an S3 endpoint within the VPC
- `map_public_ip_on_launch` - should be false if you do not want to auto-assign public IP on launch
- `private_propagating_vgws` - list of VGWs the private route table should propagate
- `public_propagating_vgws` - list of VGWs the public route table should propagate
- `tags` - dictionary of tags that will be added to resources created by the module
- `public_subnet_tags` - dictionary of tags that will be added to public subnets created by the module
- `private_subnet_tags` - dictionary of tags that will be added to private subnets created by the module
- `database_subnet_tags` - dictionary of tags that will be added to database subnets created by the module
- `elasticache_subnet_tags` - dictionary of tags that will be added to elasticache subnets created by the module

It's generally preferable to keep `public_subnets`, `private_subnets`, and
`azs` to lists of the same length.

This module optionally creates NAT Gateways (one per availability zone) and sets them
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

Usage with other modules
------------------------

There are situations where other modules will be used alongside this module, but
all the networking components out of this module (such as route tables, NAT
Gateways and Internet Gateways) needs to be provisioned first before resources
(such as EC2 instances) can be created in other modules. Use of `depends_id` as
an output variable provides a suitable workaround.

Here is an example of usage alongside the `tf_aws_bastion_s3_keys` community
module so that the bastion host is only created once all resources in the VPC
module has been created.

```hcl
module "vpc" {
  ...
}

module "bastion" {
  source                      = "github.com/terraform-community-modules/tf_aws_bastion_s3_keys"
  instance_type               = "t2.micro"
  ami                         = "ami-123456"
  region                      = "eu-west-1"
  iam_instance_profile        = "s3_readonly"
  s3_bucket_name              = "public-keys-demo-bucket"
  vpc_id                      = "vpc-123456"
  subnet_ids                  = ["subnet-123456", "subnet-6789123", "subnet-321321"]
  keys_update_frequency       = "5,20,35,50 * * * *"
  additional_user_data_script = "echo ${module.vpc.depends_id}"
}
```

Outputs
=======

 - `vpc_id` - does what it says on the tin
 - `private_subnets` - list of private subnet ids
 - `public_subnets` - list of public subnet ids
 - `database_subnets` - list of database subnets ids
 - `database_subnet_group` - db subnet group name
 - `elasticache_subnets` - list of elasticache subnets ids
 - `elasticache_subnet_group` - elasticache subnet group name
 - `public_route_table_ids` - list of public route table ids
 - `private_route_table_ids` - list of private route table ids
 - `default_security_group_id` - VPC default security group id string
 - `nat_eips` - list of Elastic IP ids (if any are provisioned)
 - `nat_eips_public_ips` - list of NAT gateways' public Elastic IP's (if any are provisioned)
 - `natgw_ids` - list of NAT gateway ids
 - `igw_id` - Internet Gateway id string
 - `depends_id` - this can be used when resources in other modules depend on completion of all resources in this module

**NOTE**: previous versions of this module returned a single string as a route
table ID, while this version returns a list.

Authors
=======

Originally created and maintained by [Casey Ransom](https://github.com/cransom)
Hijacked by [Paul Hinze](https://github.com/phinze)

License
=======

Apache 2 Licensed. See LICENSE for full details.
