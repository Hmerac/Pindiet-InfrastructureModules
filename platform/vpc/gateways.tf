# Create Internet GW
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.environment}-IGW"
    Environment = "${var.environment}"
  }
}

# Create NAT GW for AZ-a
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.ng_elastic_ip_1.id}"
  subnet_id     = "${element(aws_subnet.public_subnet.*.id, 0)}"
  depends_on    = ["aws_subnet.public_subnet", "aws_eip.ng_elastic_ip_1", "aws_internet_gateway.internet_gateway"]

  tags {
    Name        = "${var.environment}-${element(var.availability_zones, 0)}-NGW"
    Environment = "${var.environment}"
  }
}

# Create NAT GW for AZ-b
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.ng_elastic_ip_2.id}"
  subnet_id     = "${element(aws_subnet.public_subnet.*.id, 1)}"
  depends_on    = ["aws_subnet.public_subnet", "aws_eip.ng_elastic_ip_2", "aws_internet_gateway.internet_gateway"]

  tags {
    Name        = "${var.environment}-${element(var.availability_zones, 1)}-NGW"
    Environment = "${var.environment}"
  }
}