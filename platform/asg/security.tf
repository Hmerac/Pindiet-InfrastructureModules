##################################################
########                 SG               ########
##################################################
# Create Security Group for ECS Instances
resource "aws_security_group" "ecs-security-group" {
  name        = "${var.environment}-${var.cluster_name}-ecs-sg"
  description = "Allows ports 22 and 32768-65535 for clusters"
  vpc_id      = "${data.terraform_remote_state.vpc_state.vpc_id}"

  ingress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["${data.terraform_remote_state.vpc_state.vpc_cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.environment}-${var.cluster_name}-ecs-sg"
    Environment = "${var.environment}"
  }
}
