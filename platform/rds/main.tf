##################################################
########             Backend              ########
##################################################
# Configure backend remote state with S3
terraform {
  backend "s3" {}
}

##################################################
########           RDS Instance           ########
##################################################
# TODO: Configure snapshotting
# Create MySQL RDS Instance
resource "aws_db_instance" "rds" {
  identifier             = "${var.environment}-${var.identifier}"
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
  storage_encrypted      = true

  tags {
    Name        = "${var.environment}-${var.database_name}"
    Environment = "${var.environment}"
  }
}

##################################################
########             KMS Key              ########
##################################################
# Create a CMK to encrypt RDS
/*resource "aws_kms_key" "rds_encryption_key" {
  description = "CMK to encrypt RDS"
}*/

##################################################
########          KMS Key Alias           ########
##################################################
# Create an alias for RDS CMK
/*resource "aws_kms_alias" "rds_encryption_key_alias" {
  name          = "alias/rds-encryption-key"
  target_key_id = "${aws_kms_key.rds_encryption_key.id}"
}*/

# Write output values to the state file in S3 so that other components can use it
output "rds_endpoint" {
  value = "${aws_db_instance.rds.endpoint}"
}