terraform {
  backend "s3" {}
}

resource "aws_autoscaling_policy" "scale_up_policy" {
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${var.cluster_name}-asg"
  cooldown               = "300"
  name                   = "${var.cluster_name}-asg-scaleup-policy"
  scaling_adjustment     = "${var.number_of_instance_to_scale_up}"
  depends_on = ["aws_autoscaling_group.ecs"]
}

resource "aws_autoscaling_policy" "scale_down_policy" {
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${var.cluster_name}-asg"
  cooldown               = "300"
  name                   = "${var.cluster_name}-asg-scaledown-policy"
  scaling_adjustment     = "${var.number_of_instance_to_scale_down}"
  depends_on = ["aws_autoscaling_group.ecs"]
}