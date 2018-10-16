##################################################
########              Lambda              ########
##################################################
# Create a Lambda to collect related metrics and write them to CW after processing
resource "aws_lambda_function" "lambda_function" {
  function_name    = "${var.environment}-instance-monitoring"
  filename         = "instance-monitoring/instance-monitoring.zip"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  role             = "${aws_iam_role.ecs_autoscale_role.arn}"
  handler          = "${var.handler}"
  runtime          = "${var.runtime}"
  timeout          = "${var.timeout}"
  memory_size      = "${var.memory_size}"

  vpc_config {
    # TODO: Configure Security Group for the Instances inside Cluster later on
    security_group_ids = ["${aws_security_group.ecs-security-group.id}"]
    subnet_ids         = ["${data.terraform_remote_state.vpc_state.private_subnet_id_list}"]
  }
}

##################################################
########        Lambda Permission         ########
##################################################
# Appropriate permissions for related Lambda script
resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id    = "${aws_cloudwatch_event_rule.event_rule.name}"
  action          = "lambda:InvokeFunction"
  function_name   = "${aws_lambda_function.lambda_function.function_name}"
  principal       = "events.amazonaws.com"
  source_arn      = "${aws_cloudwatch_event_rule.event_rule.arn}"
}

##################################################
########           Archive File           ########
##################################################
# Make a .zip file from .py file to use it with Lambda Function
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "scripts"
  output_path = "instance-monitoring/instance-monitoring.zip"
}