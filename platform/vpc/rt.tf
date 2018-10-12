##################################################
########            Public RT             ########
##################################################
# Create public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "${var.environment}-public-rt"
    Environment = "${var.environment}"
  }
}

# Create public route for Internet GW
resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
}

# Create associations for public subnets and public route tables
resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

##################################################
########           Private RT             ########
##################################################
# TODO: Will need to create another Private Route Table for another NAT GW
# Create private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "${var.environment}-private-rt"
    Environment = "${var.environment}"
  }
}

# Create private route for NAT GW
resource "aws_route" "private_nat_gateway" {
  route_table_id         = "${aws_route_table.private_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat_gateway.id}"
}

# Create associations for private subnets and private route tables
resource "aws_route_table_association" "private" {
  count           = "${length(var.private_subnets_cidr)}"
  subnet_id       = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id  = "${aws_route_table.private_route_table.id}"
}