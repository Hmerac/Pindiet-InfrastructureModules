# Configure backend remote state with S3
terraform {
  backend "s3" {}
}

# Create the main VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "${var.vpc_name}"
    Description = "Main VPC to hold seperate environments"
  }
}

output "vpc_id" {
  value = "${aws_vpc.main_vpc.id}"
}