terraform {
  backend "s3" {}
}

resource "aws_alb" "ext_alb" {
  name                      = "${var.ext_alb_name}"
  internal                  = false
  security_groups           = ["${aws_security_group.ext_alb_sg.id}"]
  subnets                   = ["${data.terraform_remote_state.vpc_state.public_subnet_id_list}"]

  access_logs {
    bucket  = "${aws_s3_bucket.ext_alb_s3_bucket.id}"
    prefix  = "${var.ext_alb_prefix}"
    enabled = true
  }

  tags {
    Name        = "${var.ext_alb_name}"
    Environment = "${var.environment}"
  }
}

resource "aws_alb" "int_alb" {
  name                      = "${var.int_alb_name}"
  internal                  = true
  security_groups           = ["${aws_security_group.int_alb_sg.id}"]
  subnets                   = ["${data.terraform_remote_state.vpc_state.private_subnet_id_list}"]

  access_logs {
    bucket  = "${aws_s3_bucket.int_alb_s3_bucket.id}"
    prefix  = "${var.int_alb_prefix}"
    enabled = true
  }

  tags {
    Name        = "${var.int_alb_name}"
    Environment = "${var.environment}"
  }
}

resource "aws_alb_listener" "ext_alb_listener" {
  load_balancer_arn = "${aws_alb.ext_alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.front.id}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "int_alb_listener" {
  load_balancer_arn = "${aws_alb.int_alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.back.id}"
    type             = "forward"
  }
}

resource "aws_alb_target_group" "front" {
  name     = "${var.target_group_name}"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/${element(split(",", var.health_check_path), count.index + 1 )}"
  }

  tags {
    Name        = "${var.target_group_name}"
    Environment = "${var.environment}"
  }
}

resource "aws_alb_target_group" "back" {
  name     = "${var.target_group_name}"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/${var.health_check_path}"
  }

  tags {
    Name        = "${var.target_group_name}"
    Environment = "${var.environment}"
  }
}