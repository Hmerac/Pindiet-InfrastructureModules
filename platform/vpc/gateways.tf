# Create Internet GW
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.environment}-IGW"
    Environment = "${var.environment}"
  }
}

# Create NAT GW
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.ng_elastic_ip.id}"
  subnet_id     = "${element(aws_subnet.public_subnet.*.id, 0)}"
  depends_on    = ["aws_internet_gateway.internet_gateway"]

  tags {
    Name = "${var.environment}-Main-NG"
    Environment = "${var.environment}"
  }
}