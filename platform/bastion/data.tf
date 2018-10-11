##################################################
########             Template             ########
##################################################
# Render initialization script so that it gets executed when instance boots
data "template_file" "user_data" {
  template = "${file("${path.module}/scripts/user-data.sh")}"
}

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