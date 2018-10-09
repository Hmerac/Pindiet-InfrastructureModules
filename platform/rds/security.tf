resource "aws_security_group" "db_access_sg" {
  vpc_id      = "${data.terraform_remote_state.vpc_state.vpc_id}"
  name        = "${var.environment}-DB-Access-SG"
  description = "Allow access to RDS"

  tags {
    Name        = "DB-Access-SG"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "rds_sg" {
  name = "${var.environment}-RDS-SG"
  description = "${var.environment} RDS Security Group"
  vpc_id = "${data.terraform_remote_state.vpc_state.vpc_id}"
  tags {
    Name = "${var.environment}-RDS-SG"
    Environment =  "${var.environment}"
  }

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    security_groups = ["${aws_security_group.db_access_sg.id}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}