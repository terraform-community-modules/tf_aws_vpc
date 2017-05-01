output "private_subnets" {
  value = ["${aws_subnet.private.*.id}"]
}

output "database_subnets" {
  value = ["${aws_subnet.database.*.id}"]
}

output "database_subnet_group" {
  value = "${aws_db_subnet_group.database.id}"
}

output "public_subnets" {
  value = ["${aws_subnet.public.*.id}"]
}

output "elasticache_subnets" {
  value = ["${aws_subnet.elasticache.*.id}"]
}

output "elasticache_subnet_group" {
  value = "${aws_elasticache_subnet_group.elasticache.id}"
}

output "vpc_id" {
  value = "${aws_vpc.mod.id}"
}

output "public_route_table_ids" {
  value = ["${aws_route_table.public.*.id}"]
}

output "private_route_table_ids" {
  value = ["${aws_route_table.private.*.id}"]
}

output "default_security_group_id" {
  value = "${aws_vpc.mod.default_security_group_id}"
}

output "nat_eips" {
  value = ["${aws_eip.nateip.*.id}"]
}

output "nat_eips_public_ips" {
  value = ["${aws_eip.nateip.*.public_ip}"]
}

output "natgw_ids" {
  value = ["${aws_nat_gateway.natgw.*.id}"]
}

output "igw_id" {
  value = "${aws_internet_gateway.mod.id}"
}
