# Create Elastic IP for NAT GW 1
resource "aws_eip" "ng_elastic_ip_1" {
  vpc      = true
  depends_on = ["aws_internet_gateway.internet_gateway"]

  tags {
    Name = "${var.environment}-NG-EIP-1"
    Environment = "${var.environment}"
  }
}

# Create Elastic IP for NAT GW 2
resource "aws_eip" "ng_elastic_ip_2" {
  vpc      = true
  depends_on = ["aws_internet_gateway.internet_gateway"]

  tags {
    Name = "${var.environment}-NG-EIP-2"
    Environment = "${var.environment}"
  }
}