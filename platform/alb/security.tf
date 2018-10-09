resource "aws_security_group" "ext_alb_sg" {
  name          = "${var.environment}-${var.ext_alb_name}-SG"
  description   = "Allow ingress HTTP, HTTPS to External ALB"
  vpc_id        = "${data.terraform_remote_state.vpc_state.vpc_id}"

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

  ingress {
    protocol    = "icmp"
    from_port   = 8
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.environment}-${var.ext_alb_name}-SG"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "container_instance_sg" {
  name           = "${var.environment}-EC2-SG"
  description    = "Allow all ports to Internal EC2s"
  vpc_id         = "${data.terraform_remote_state.vpc_state.vpc_id}"

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks  = ["0.0.0.0/0"] # TODO: Add our specific IPs here to SSH
  }

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
  from_port = 32768
  to_port = 61000
  protocol = "tcp"
  security_group_id = "${aws_security_group.container_instance_sg.id}"
  source_security_group_id = "${aws_security_group.ext_alb_sg.id}"
}