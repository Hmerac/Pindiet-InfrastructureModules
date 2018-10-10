terraform {
  backend "s3" {}
}

resource "aws_alb" "ext_alb" {
  name                        = "${var.ext_alb_name}"
  internal                    = false
  load_balancer_type          = "application"
  security_groups             = ["${data.terraform_remote_state.vpc_state.default_vpc_sg.id}", "${aws_security_group.ext_alb_sg.id}"]
  subnets                     = ["${data.terraform_remote_state.vpc_state.public_subnet_id_list}"]

  access_logs {
    bucket  = "${aws_s3_bucket.ext_alb_s3_bucket.id}"
    prefix  = "${var.ext_alb_prefix}"
    enabled = true
  }

  tags {
    Name        = "${var.environment}-${var.ext_alb_name}"
    Environment = "${var.environment}"
  }
}

resource "aws_alb_listener" "ext_alb_listener" {
  load_balancer_arn = "${aws_alb.ext_alb.arn}"
  port              = "80"
  protocol          = "HTTP"
  depends_on        = ["aws_alb_target_group.alb_target_group"]

  default_action {
    target_group_arn = "${aws_alb_target_group.alb_target_group.id}"
    type             = "forward"
  }
}

resource "aws_alb_target_group" "alb_target_group" {
  name        = "${var.environment}-${var.ext_target_group_name}"
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = "${data.terraform_remote_state.vpc_state.vpc_id}"

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/"
  }

  tags {
    Name        = "${var.ext_target_group_name}"
    Environment = "${var.environment}"
  }
}

output "alb_target_group_id" {
  value = "${aws_alb_target_group.alb_target_group.id}"
}

output "alb_endpoint" {
  value = "${aws_alb.ext_alb.dns_name}"
}