# Configure backend remote state with S3
terraform {
  backend "s3" {}
}

# Create the main VPC
resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr_block}"

  tags {
    Name = "${var.vpc_name}"
    Description = "Main VPC to hold seperate environments"
  }
}

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.vpc.cidr_block}"
}