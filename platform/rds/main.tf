resource "aws_db_instance" "rds" {
  identifier             = "${var.environment}-DB"
  allocated_storage      = "${var.allocated_storage}"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "${var.instance_class}"
  multi_az               = "${var.multi_az}"
  name                   = "${var.database_name}"
  username               = "${var.database_username}"
  password               = "${var.database_password}"
  db_subnet_group_name   = "${aws_db_subnet_group.rds_subnet_group.id}"
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  skip_final_snapshot    = true
  snapshot_identifier    = "${var.database_name}-${var.environment}-Snapshot"
  tags {
    Name        = "${var.database_name}"
    Environment = "${var.environment}"
  }
}