# Create ACL for public subnets
resource "aws_network_acl" "public_nacl" {
  vpc_id = "${aws_vpc.main_vpc.id}"
  subnet_ids = ["${aws_subnet.public_subnet_1.id}", "${aws_subnet.public_subnet_2.id}"]
}

# Create ssh ingress-egress for public ACL
resource "aws_network_acl_rule" "public_nacl_ssh_rule" {
  network_acl_id = "${aws_network_acl.public_nacl.id}"
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

# Create http ingress-egress for public ACL
resource "aws_network_acl_rule" "public_nacl_http_rule" {
  network_acl_id = "${aws_network_acl.public_nacl.id}"
  rule_number    = 101
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

# Create https ingress-egress for public ACL
resource "aws_network_acl_rule" "public_nacl_https_rule" {
  network_acl_id = "${aws_network_acl.public_nacl.id}"
  rule_number    = 102
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}