resource "aws_security_group" "ext_alb_sg" {
  name          = "${var.environment}-${var.ext_alb_name}-SG"
  description   = "Allow ingress SSH, HTTP, HTTPS to External ALB"
  vpc_id        = "${data.terraform_remote_state.vpc_state.id}"

  ingress {
    protocol    = "TCP"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "TCP"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "TCP"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol     = "-1"
    from_port    = 0
    to_port      = 0
    cidr_blocks  = "${aws_security_group.ext_ec2_sg.id}"
  }
}

resource "aws_security_group" "ext_ec2_sg" {
  name           = "${var.environment}-${var.ext_alb_name}-SG"
  description    = "Allow SSH to External EC2s"
  vpc_id         = "${data.terraform_remote_state.vpc_state.id}"

  ingress {
    protocol     = "TCP"
    from_port    = 22
    to_port      = 22

    # Dynamic Port Range for Application Load Balancer
    security_groups = ["${aws_security_group.ext_alb_sg.id}"]
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

resource "aws_security_group" "int_alb_sg" {
  name          = "${var.environment}-${var.int_alb_name}-SG"
  description   = "Allow SSH, HTTP, HTTPS to Internal ALB"
  vpc_id        = "${data.terraform_remote_state.vpc_state.id}"

  ingress {
    protocol    = "TCP"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["${data.terraform_remote_state.vpc_state.public_subnet_id_list}"]
  }

  ingress {
    protocol    = "TCP"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "TCP"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol     = "-1"
    from_port    = 0
    to_port      = 0
    cidr_blocks  = "${aws_security_group.int_ec2_sg.id}"
  }
}

resource "aws_security_group" "int_ec2_sg" {
  name           = "${var.environment}-${var.int_alb_name}-SG"
  description    = "Allow SSH, HTTP, HTTPS to Internal EC2s"
  vpc_id         = "${data.terraform_remote_state.vpc_state.id}"

  ingress {
    protocol     = "TCP"
    from_port    = 22
    to_port      = 22

    # Dynamic Port Range for Application Load Balancer
    security_groups = ["${aws_security_group.int_alb_sg.id}"]
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