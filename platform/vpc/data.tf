# Declare the availability zones of eu-central-1
data "aws_availability_zones" "available" {}

# Declare all public subnets
data "aws_subnet_ids" "public_subnets" {
  vpc_id = "${aws_vpc.main_vpc.id}"
  tags {
    Tier = "Public"
  }
}