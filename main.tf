resource "aws_vpc" "mod" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_internet_gateway" "mod" {
  vpc_id = "${aws_vpc.mod.id}"

  tags {
    Name = "${var.name}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id           = "${aws_vpc.mod.id}"
  propagating_vgws = ["${var.public_propagating_vgws}"]

  tags {
    Name = "${var.name}-rt-public"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.mod.id}"
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.natgw.*.id, count.index)}"
  count                  = "${length(var.private_subnets) * lookup(map(var.enable_nat_gateway, 1), "true", 0)}"
}

resource "aws_route_table" "private" {
  vpc_id           = "${aws_vpc.mod.id}"
  propagating_vgws = ["${var.private_propagating_vgws}"]
  count            = "${length(var.private_subnets)}"

  tags {
    Name = "${var.name}-rt-private-${element(var.azs, count.index)}"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"
  count             = "${length(var.private_subnets)}"

  tags {
    Name = "${var.name}-subnet-private-${element(var.azs, count.index)}"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.public_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"
  count             = "${length(var.public_subnets)}"

  tags {
    Name = "${var.name}-subnet-public-${element(var.azs, count.index)}"
  }

  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}

resource "aws_eip" "nateip" {
  vpc   = true
  count = "${length(var.private_subnets) * lookup(map(var.enable_nat_gateway, 1), "true", 0)}"
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = "${element(aws_eip.nateip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  count         = "${length(var.private_subnets) * lookup(map(var.enable_nat_gateway, 1), "true", 0)}"

  depends_on = ["aws_internet_gateway.mod"]
}

resource "aws_route_table_association" "private" {
  count          = "${length(var.private_subnets)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}
