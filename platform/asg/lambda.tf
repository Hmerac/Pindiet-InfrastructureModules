resource "aws_lambda_function" "lambda_function" {
  function_name    = "${var.cluster_name}-instance-monitoring"
  filename         = "${file("${path.module}/scripts/instance-monitoring.py")}"
  role             = "${aws_iam_role.ecs_autoscale_role.arn}"
  handler          = "${var.handler}" #index.lambda_handler
  runtime          = "${var.runtime}" #python2.7
  timeout          = "${var.timeout}" #10
  memory_size      = "${var.memory_size}" #128

  vpc_config {
    # TODO: Configure Security Group for the Instances inside Cluster later on
    security_group_ids = ["${data.terraform_remote_state.vpc_state.default_vpc_sg}"]
    subnet_ids         = ["${data.terraform_remote_state.vpc_state.private_subnet_list}"]
  }
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id    = "${aws_cloudwatch_event_rule.event_rule.name}"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_function.function_name}"
  principal = "events.amazonaws.com"
  source_arn = "${aws_cloudwatch_event_rule.event_rule.arn}"
}


resource "aws_cloudwatch_event_rule" "event_rule" {
  name            = "${var.cluster_name}-schedulecontainer"
  description     = "${var.cluster_name}-ScheduleContainer triggers lambda for instance scaling"
  schedule_expression = "rate(1 minute)"
}


resource "aws_cloudwatch_event_target" "event_target" {
  rule      = "${aws_cloudwatch_event_rule.event_rule.name}"
  arn       = "${aws_lambda_function.lambda_function.arn}"
  input = <<INPUT
  {
     "ECS_CLUSTER" : "${var.cluster_name}"
  }
INPUT
}