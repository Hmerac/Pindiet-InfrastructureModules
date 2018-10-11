##################################################
########           Elastic IP             ########
##################################################
# TODO: Will need to allocate another EIPs for NAT GWs
# Create Elastic IP for NAT GW
resource "aws_eip" "ng_elastic_ip" {
  vpc         = true
  depends_on  = ["aws_internet_gateway.internet_gateway"]

  tags {
    Name        = "${var.environment}-ng-eip"
    Environment = "${var.environment}"
  }
}