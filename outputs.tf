output "${mytag}_vpc_id" {
    value = "${aws_vpc.vpc.id}"
}
output "vpc_cidr_block" {
    value = "${aws_vpc.vpc.cidr_block}"
}
output "vpc_route_table_id" {
    value = "${aws_vpc.vpc.main_route_table_id}"
}
output "vpc_default_network_acl_id" {
    value = "${aws_vpc.vpc.default_network_acl_id}"
}
output "vpc_default_security_group_id" {
    value = "${aws_vpc.vpc.default_security_group_id}"
}
/* docs say this exist, it doesn't
output "vpc_instance_tenancy" {
    value = "${aws_vpc.vpc.instance_tenancy}"
}
*/
