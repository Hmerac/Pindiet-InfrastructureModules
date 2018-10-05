# Create a public subnet with eu-central-1a AZ
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = "${aws_vpc.main_vpc.id}"
  cidr_block = "10.0.0.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "Public Subnet 1"
    Tier = "Public"
  }
}

# Create a public subnet with eu-central-1b AZ
resource "aws_subnet" "public_subnet_2" {
  vpc_id     = "${aws_vpc.main_vpc.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name = "Private Subnet 2"
    Tier = "Public"
  }
}

# Create a private subnet with eu-central-1a AZ
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = "${aws_vpc.main_vpc.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "Private Subnet 1"
    Tier = "Private"
  }
}

# Create a private subnet with eu-central-1b AZ
resource "aws_subnet" "private_subnet_2" {
  vpc_id     = "${aws_vpc.main_vpc.id}"
  cidr_block = "10.0.3.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name = "Private Subnet 2"
    Tier = "Private"
  }
}