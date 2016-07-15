variable "name" { }
variable "cidr" { }
variable "public_subnets" { default = "" }
variable "private_subnets" { default = "" }
variable "azs" { }
variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default = false
}
variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default = false
}
variable "private_propagating_vgws" {
  description = "A comma separated list of VGWs the private route table should propagate."
  default = ""
}
variable "public_propagating_vgws" {
  description = "A comma separated list of VGWs the public route table should propagate."
  default = ""
}
