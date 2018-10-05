# Create public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags {
    Name = "Public-RT"
  }
}

# Create public route for Internet GW
resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"

  timeouts {
    create = "1m"
  }
}

# Create private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags {
    Name = "Private-RT"
  }
}

# Create private route for NAT GW
resource "aws_route" "private_nat_gateway" {
  route_table_id         = "${aws_route_table.private_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat_gateway.id}"

  timeouts {
    create = "5m"
  }
}