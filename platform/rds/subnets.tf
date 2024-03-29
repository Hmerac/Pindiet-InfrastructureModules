##################################################
########             DB Subnet            ########
##################################################
# Define a DB Subnet inside private subnets
resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.environment}-rds-subnet-group"
  description = "RDS Subnet Group"
  subnet_ids  = ["${data.terraform_remote_state.vpc_state.private_subnet_id_list}"]

  tags {
    Name        = "${var.environment}-rds-subnet-group"
    Environment = "${var.environment}"
  }
}