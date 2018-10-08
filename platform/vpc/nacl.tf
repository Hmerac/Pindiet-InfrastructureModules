##################################################
########            Public ACL            ########
##################################################

# Create ACL for public subnets
resource "aws_network_acl" "public_nacl" {
  vpc_id = "${aws_vpc.main_vpc.id}"
  subnet_ids = ["${aws_subnet.public_subnet_1.id}", "${aws_subnet.public_subnet_2.id}"]
}

# Create ssh ingress for public ACL
resource "aws_network_acl_rule" "public_nacl_ssh_rule" {
  network_acl_id = "${aws_network_acl.public_nacl.id}"
  rule_number    = 104
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

# Create http ingress for public ACL
resource "aws_network_acl_rule" "public_nacl_http_rule" {
  network_acl_id = "${aws_network_acl.public_nacl.id}"
  rule_number    = 105
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

# Create https ingress for public ACL
resource "aws_network_acl_rule" "public_nacl_https_rule" {
  network_acl_id = "${aws_network_acl.public_nacl.id}"
  rule_number    = 106
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

# Create ephemeral ports ingress for public ACL
resource "aws_network_acl_rule" "public_nacl_https_rule" {
  network_acl_id = "${aws_network_acl.public_nacl.id}"
  rule_number    = 107
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

# Create ssh egress for public ACL
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

# Create http egress for public ACL
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

# Create https egress for public ACL
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

# Create MySQL egress for public ACL
resource "aws_network_acl_rule" "public_nacl_ssh_rule" {
  network_acl_id = "${aws_network_acl.public_nacl.id}"
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 3306
  to_port        = 3306
}

# Create ephemeral ports egress for public ACL
resource "aws_network_acl_rule" "public_nacl_https_rule" {
  network_acl_id = "${aws_network_acl.public_nacl.id}"
  rule_number    = 103
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

##################################################
########           Private ACL            ########
##################################################

# Create ACL for private subnets
resource "aws_network_acl" "private_nacl" {
  vpc_id = "${aws_vpc.main_vpc.id}"
  subnet_ids = ["${aws_subnet.private_subnet_1.id}", "${aws_subnet.private_subnet_2.id}"]
}

# Create ssh ingress for private ACL
resource "aws_network_acl_rule" "private_nacl_ssh_rule" {
  network_acl_id = "${aws_network_acl.public_nacl.id}"
  rule_number    = 104
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

# Create http ingress for private ACL
resource "aws_network_acl_rule" "private_nacl_http_rule" {
  network_acl_id = "${aws_network_acl.public_nacl.id}"
  rule_number    = 105
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

# Create https ingress for private ACL
resource "aws_network_acl_rule" "private_nacl_https_rule" {
  network_acl_id = "${aws_network_acl.public_nacl.id}"
  rule_number    = 106
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

# Create ephemeral ports ingress for private ACL
resource "aws_network_acl_rule" "private_nacl_https_rule" {
  network_acl_id = "${aws_network_acl.public_nacl.id}"
  rule_number    = 107
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

# Create ssh egress for private ACL
resource "aws_network_acl_rule" "private_nacl_ssh_rule" {
  network_acl_id = "${aws_network_acl.private_nacl.id}"
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

# Create http egress for private ACL
resource "aws_network_acl_rule" "private_nacl_http_rule" {
  network_acl_id = "${aws_network_acl.private_nacl.id}"
  rule_number    = 101
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

# Create https egress for private ACL
resource "aws_network_acl_rule" "private_nacl_https_rule" {
  network_acl_id = "${aws_network_acl.private_nacl.id}"
  rule_number    = 102
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

# Create ephemeral ports egress for private ACL
resource "aws_network_acl_rule" "private_nacl_https_rule" {
  network_acl_id = "${aws_network_acl.private_nacl.id}"
  rule_number    = 103
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}