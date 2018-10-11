##################################################
########                 SG               ########
##################################################
# Create Security Group for Bastion
resource "aws_security_group" "bastion_security_group" {
  name        = "${var.bastion_name}-sg"
  description = "Allows only port 22 for VPC"
  vpc_id      = "${data.terraform_remote_state.vpc_state.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allows only port 22 for VPC"
  }

  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.bastion_name}-sg"
  }
}
