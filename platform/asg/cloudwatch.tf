resource "aws_cloudwatch_metric_alarm" "auth_service_cpu_high" {
  alarm_name          = "${var.environment}-${aws_ecs_service.auth.name}-service-cpu-utilization-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "85"

  dimensions {
    ClusterName = "${data.terraform_remote_state.vpc_state.ecs_cluster_name}"
    ServiceName = "${aws_ecs_service.auth.name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.up.arn}"]
  ok_actions    = ["${aws_appautoscaling_policy.down.arn}"]
}