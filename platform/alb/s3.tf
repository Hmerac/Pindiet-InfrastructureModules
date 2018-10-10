resource "aws_s3_bucket" "ext_alb_s3_bucket" {
  bucket = "${var.environment}-${var.ext_alb_name}"
  acl    = "private"

  tags {
    Name        = "${var.environment}-${var.ext_alb_name}-S3"
    Environment = "${var.environment}"
  }
}

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