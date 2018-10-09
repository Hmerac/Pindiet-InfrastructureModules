terraform {
  backend "s3" {}
}

resource "aws_instance" "bastion_for_rds" {
  ami                         = "ami-0233214e13e500f77"
  instance_type               = "t2.micro"
  user_data                   = "${data.template_file.user_data.rendered}"
  subnet_id                   = "${data.terraform_remote_state.private_subnet_source.private_subnet_id_list[0]}"
  vpc_security_group_ids      = ["${aws_security_group.bastion_security_group.id}"]
  key_name                    = "${var.bastion_keypair_name}"

  tags {
    Name                      = "${var.bastion_name}"
    Environment               = "${var.environment}"
  }
}