data "aws_ami" "ecs_ami" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["*-amazon-ecs-optimized"]
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/scripts/user-data.sh")}"

  vars {
    cluster_name = "${var.cluster_name}"
  }
}

data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config {
    bucket = "${var.vpc_state_bucket}"
    key    = "${var.vpc_state_key}"
    region = "${var.region}"
  }
}