##################################################
########         AWS Service Data         ########
##################################################
# Retrieve the ALB principle ID for ALB S3 access logs
data "aws_elb_service_account" "elb_service_account" {}

##################################################
########            State Data            ########
##################################################
# Create data resource to retrieve required VPC data from its state file in S3
data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config {
    bucket = "${var.vpc_state_bucket}"
    key    = "${var.vpc_state_key}"
    region = "${var.region}"
  }
}