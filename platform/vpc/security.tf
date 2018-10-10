resource "aws_security_group" "default_vpc_sg" {
  name        = "${var.environment}-VPC-Default-SG"
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
    Name        = "${var.environment}-VPC-Default-SG"
    Environment = "${var.environment}"
  }
}

output "default_vpc_sg" {
  value = "${aws_security_group.default_vpc_sg.id}"
}