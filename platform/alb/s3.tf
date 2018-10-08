resource "aws_s3_bucket" "ext_alb_s3_bucket" {
  bucket = "${var.environment}-${var.ext_alb_name}-S3"
  acl    = "private"

  tags {
    Name        = "${var.environment}-${var.ext_alb_name}-S3"
    Environment = "${var.environment}"
  }
}