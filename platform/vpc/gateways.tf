##################################################
########           Internet GW            ########
##################################################
# Create Internet GW
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "${var.environment}-igw"
    Environment = "${var.environment}"
  }
}

##################################################
########              NAT GW              ########
##################################################
# TODO: Having one NAT on environments isn't a recommended practice, implement one NAT per AZ later on
# Create NAT GW
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.ng_elastic_ip.id}"
  subnet_id     = "${element(aws_subnet.public_subnet.*.id, 0)}"
  depends_on    = ["aws_subnet.public_subnet", "aws_eip.ng_elastic_ip", "aws_internet_gateway.internet_gateway"]

  tags {
    Name        = "${var.environment}-${element(var.availability_zones, 0)}-ngw"
    Environment = "${var.environment}"
  }
}