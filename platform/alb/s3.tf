##################################################
########               ALB S3             ########
##################################################
# Create S3 Bucket for collecting access logs
resource "aws_s3_bucket" "ext_alb_s3_bucket" {
  bucket = "${var.environment}-${var.ext_alb_name}"
  acl    = "private"
  force_destroy = true

  tags {
    Name        = "${var.environment}-${var.ext_alb_name}-s3"
    Environment = "${var.environment}"
  }
}

##################################################
########               ALB S3             ########
##################################################
# Create S3 Policy so that ALB can write to S3 Bucket
resource "aws_s3_bucket_policy" "ext_alb_s3_bucket_access_logs_policy" {
  bucket = "${aws_s3_bucket.ext_alb_s3_bucket.id}"
  policy =<<EOF
{
  "Id": "Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.environment}-${var.ext_alb_name}/AWSLogs/*",
      "Principal": {
        "AWS": [
          "${data.aws_elb_service_account.elb_service_account.arn}"
        ]
      }
    }
  ]
}
EOF
}