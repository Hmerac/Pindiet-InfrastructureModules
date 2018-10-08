data "aws_vpc" "vpc_source" {
  id = "${var.vpc_id}"
}

data "aws_subnet_ids" "subnet_source" {
  vpc_id = "${data.aws_vpc.vpc_source.id}"
}