##################################################
########           Default SG             ########
##################################################
# Default VPC Security Group which allows all ingress/egress rules
resource "aws_security_group" "default_vpc_sg" {
  name        = "${var.environment}-vpc-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = "${aws_vpc.vpc.id}"
  depends_on  = ["aws_vpc.vpc"]

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }

  tags {
    Name        = "${var.environment}-vpc-default-sg"
    Environment = "${var.environment}"
  }
}

# Write output values to the state file in S3 so that other components can use it
output "default_vpc_sg" {
  value = "${aws_security_group.default_vpc_sg.id}"
}