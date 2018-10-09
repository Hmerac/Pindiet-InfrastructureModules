terraform {
  backend "s3" {}
}

resource "aws_appautoscaling_target" "auth_autoscaling_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${data.terraform_remote_state.vpc_state.ecs_cluster_name}/${aws_ecs_service.auth.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = "${aws_iam_role.ecs_autoscale_role.arn}"
  min_capacity       = "${var.min_capacity}"
  max_capacity       = "${var.max_capacity}"
}

resource "aws_appautoscaling_policy" "up" {
  name                    = "${var.environment}-${aws_ecs_service.auth.name}-scale-up"
  service_namespace       = "ecs"
  resource_id             = "service/${data.terraform_remote_state.vpc_state.ecs_cluster_name}/${aws_ecs_service.auth.name}"
  scalable_dimension      = "ecs:service:DesiredCount"
  depends_on              = ["aws_appautoscaling_target.auth_autoscaling_target"]

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment = 1
    }
  }
}

resource "aws_appautoscaling_policy" "down" {
  name                    = "${var.environment}-${aws_ecs_service.auth.name}-scale-down"
  service_namespace       = "ecs"
  resource_id             = "service/${data.terraform_remote_state.vpc_state.ecs_cluster_name}/${aws_ecs_service.auth.name}"
  scalable_dimension      = "ecs:service:DesiredCount"
  depends_on              = ["aws_appautoscaling_target.auth_autoscaling_target"]

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment = -1
    }
  }
}