data "aws_subnet_ids" "subnet_source" {
  vpc_id = "${data.terraform_remote_state.vpc_state.vpc_id}"
}

data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config {
    bucket = "${var.vpc_state_bucket}"
    key    = "${var.vpc_state_key}"
    region = "${var.region}"
  }
}