# Create Elastic IP for NAT GW
resource "aws_eip" "ng_elastic_ip" {
  vpc      = true

  tags {
    name = "EIP-NG"
  }
}