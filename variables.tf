variable "name" { }
variable "cidr" { }
variable "public_subnets" { }
variable "private_subnets" { }
variable "azs" { }
variable "enable_dns_hostnames" {
  default = false
}
