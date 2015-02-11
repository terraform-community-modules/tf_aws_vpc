// Provider specific configs
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

// Spin up the VPC.
resource "aws_vpc" "vpc" {
    cidr_block = "${var.cidr_block}"
    tags {
        Name = "${var.environment_name}"
    }
}

