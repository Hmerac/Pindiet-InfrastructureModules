# Create a public subnet for each AZ
resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  count                   = "${length(var.public_subnets_cidr)}"
  cidr_block              = "${element(var.public_subnets_cidr, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name        = "${var.environment}-${element(var.availability_zones, count.index)}-Public-Subnet-${count.index}"
    Environment = "${var.environment}"
    AZ          = "${element(var.availability_zones, count.index)}"
    Type        = "Public"
  }
}

# Create a private subnet for each AZ
resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  count                   = "${length(var.public_subnets_cidr)}"
  cidr_block              = "${element(var.private_subnets_cidr, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"

  tags {
    Name        = "${var.environment}-${element(var.availability_zones, count.index)}-Private-Subnet-${count.index}"
    Environment = "${var.environment}"
    AZ          = "${element(var.availability_zones, count.index)}"
    Type        = "Private"
  }
}

output "public_subnet_id_list" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}

output "private_subnet_id_list" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}