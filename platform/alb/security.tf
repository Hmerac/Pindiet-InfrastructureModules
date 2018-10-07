resource "aws_security_group" "ext_alb_sg" {
  name          = "${var.environment}-${var.ext_alb_name}-SG"
  description   = "Allow ingress SSH, HTTP, HTTPS to External ALB"
  vpc_id        = "${data.terraform_remote_state.vpc_state.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "ext_alb_to_ec2" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "tcp"
  security_group_id = "${aws_security_group.ec2_sg.id}"
  source_security_group_id = "${aws_security_group.ext_alb_sg.id}"
}

resource "aws_security_group" "int_alb_sg" {
  name          = "${var.environment}-${var.int_alb_name}-SG"
  description   = "Allow SSH, HTTP, HTTPS to Internal ALB"
  vpc_id        = "${data.terraform_remote_state.vpc_state.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["${data.terraform_remote_state.vpc_state.vpc_cidr_block}"]
  }
}

resource "aws_security_group_rule" "int_alb_to_ec2" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "tcp"
  security_group_id = "${aws_security_group.ec2_sg.id}"
  source_security_group_id = "${aws_security_group.int_alb_sg.id}"
}

resource "aws_security_group" "ec2_sg" {
  name           = "${var.environment}-${var.int_alb_name}-SG"
  description    = "Allow all ports to Internal EC2s"
  vpc_id         = "${data.terraform_remote_state.vpc_state.id}"

  egress {
    protocol     = "-1"
    from_port    = 0
    to_port      = 0
    cidr_blocks  = ["0.0.0.0/0"]
  }

  tags {
    Name         = "EC2-SG"
    Environemnt  = "${var.environment}"
  }
}

resource "aws_security_group_rule" "from_ext_alb_to_ec2" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "tcp"
  security_group_id = "${aws_security_group.ec2_sg.id}"
  source_security_group_id = "${aws_security_group.ext_alb_sg.id}"
}

resource "aws_security_group_rule" "from_int_alb_to_ec2" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "tcp"
  security_group_id = "${aws_security_group.ec2_sg.id}"
  source_security_group_id = "${aws_security_group.int_alb_sg.id}"
}