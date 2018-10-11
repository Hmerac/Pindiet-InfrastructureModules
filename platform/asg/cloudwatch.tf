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