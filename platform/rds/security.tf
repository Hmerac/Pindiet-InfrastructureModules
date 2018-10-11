##################################################
########             Main SG              ########
##################################################
# This SG will be attached to RDS, inheriting imgress from the Complementary SG
resource "aws_security_group" "rds_sg" {
  name        = "${var.environment}-rds-sg"
  description = "${var.environment} RDS Security Group"
  vpc_id      = "${data.terraform_remote_state.vpc_state.vpc_id}"

  # Allows traffic from the SG itself
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  # Inherit Complementary SG
  ingress {
    from_port         = 3306
    to_port           = 3306
    protocol          = "tcp"
    security_groups   = ["${aws_security_group.db_access_sg.id}"]
  }

  # Outbound internet access
  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.environment}-rds-sg"
    Environment =  "${var.environment}"
  }
}

##################################################
########         Complementary SG         ########
##################################################
# TODO: Define who to connect to RDS here
# This SG is used by Main SG's 3306 port ingress rule, defines who to connect RDS
resource "aws_security_group" "db_access_sg" {
  vpc_id      = "${data.terraform_remote_state.vpc_state.vpc_id}"
  name        = "${var.environment}-db-access-sg"
  description = "Allow access to RDS"

  tags {
    Name        = "${var.environment}-db-access-sg"
    Environment = "${var.environment}"
  }
}
