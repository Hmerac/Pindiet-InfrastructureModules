resource "aws_cloudwatch_metric_alarm" "schedulable_containers_high_alert" {
  actions_enabled     = true
  alarm_actions       = ["${aws_autoscaling_policy.scale_up_policy.arn}"]
  alarm_description   = "${var.cluster_name}-schedulablecontainershighalert"
  alarm_name          = "${var.cluster_name}-schedulablecontainershighalert"
  comparison_operator = "LessThanOrEqualToThreshold"

  dimensions = {
    "ClusterName" = "${var.cluster_name}"
  }

  evaluation_periods = "${var.schedulable_containers_high_evaluation_periods}"
  metric_name        = "${var.metric_name}"
  namespace          = "${var.namespace}"
  period             = "${var.schedulable_containers_high_period}"
  statistic          = "${var.statistic_type}"
  threshold          = "${var.schedulable_containers_high_threshold}"
}

resource "aws_cloudwatch_metric_alarm" "schedulable_containers_low_alert" {
  actions_enabled     = true
  alarm_actions       = ["${aws_autoscaling_policy.scale_down_policy.arn}"]
  alarm_description   = "${var.cluster_name}-schedulablecontainerslowalert"
  alarm_name          = "${var.cluster_name}-schedulablecontainerslowalert"
  comparison_operator = "GreaterThanOrEqualToThreshold"

  dimensions = {
    "ClusterName" = "${var.cluster_name}"
  }

  evaluation_periods = "${var.schedulable_containers_low_evaluation_periods}"
  metric_name        = "${var.metric_name}"
  namespace          = "${var.namespace}"
  period             = "${var.schedulable_containers_low_period}"
  statistic          = "${var.statistic_type}"
  threshold          = "${var.schedulable_containers_low_threshold}"
  depends_on = ["aws_cloudwatch_metric_alarm.schedulable_containers_high_alert"]
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