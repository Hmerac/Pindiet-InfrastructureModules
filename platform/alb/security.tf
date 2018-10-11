##################################################
########              ALB SG              ########
##################################################
# Create SG for ALB
resource "aws_security_group" "ext_alb_sg" {
  name          = "${var.environment}-${var.ext_alb_name}-sg"
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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.environment}-${var.ext_alb_name}-sg"
    Environment = "${var.environment}"
  }
}