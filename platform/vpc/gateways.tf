# Create Internet GW
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags {
    Name = "Main-IG"
  }
}

# TODO: Currently we have one NAT GW for two private subnets, we will need to configure NAT GW for each subnet we have later on
# Create NAT GW
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.ng_elastic_ip.id}"
  subnet_id     = "${aws_subnet.public_subnet_1.id}"

  depends_on = ["aws_internet_gateway.internet_gateway"]

  tags {
    Name = "Main-NG"
  }
}