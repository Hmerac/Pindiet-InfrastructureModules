##################################################
########             Backend              ########
##################################################
# Configure backend remote state with S3
terraform {
  backend "s3" {}
}

##################################################
########             ASG Group            ########
##################################################
# Autoscaling group for ECS Services
resource "aws_autoscaling_group" "ecs_asg" {
  name                 = "${var.environment}-${var.cluster_name}-asg"
  launch_configuration = "${aws_launch_configuration.ecs_launch_configuration.name}"
  vpc_zone_identifier  = ["${data.terraform_remote_state.vpc_state.private_subnet_id_list}"]
  min_size             = "${var.min_instance_num}"
  max_size             = "${var.max_instance_num}"
  desired_capacity     = "${var.desired_instance_num}"

  tag {
    key                 = "Name"
    value               = "${var.environment}-${var.cluster_name}-asg"
    propagate_at_launch = true
  }
  tag {
    key                 = "Environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
}

##################################################
########       Launch Configuration       ########
##################################################
# Launch configuration for ECS ASG related instances
resource "aws_launch_configuration" "ecs_launch_configuration" {
  name                 = "${var.environment}-${var.cluster_name}-launch-configuration"
  image_id             = "${data.aws_ami.ecs_ami.id}"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.ecs_keypair_name}"
  iam_instance_profile = "${aws_iam_instance_profile.cluster-profile.id}"
  security_groups      = ["${aws_security_group.ecs-security-group.id}"]
  user_data = "${data.template_file.user_data.rendered}"
}

##################################################
########            ASG Policy            ########
##################################################
# Scale up policy for ASG
resource "aws_autoscaling_policy" "scale_up_policy" {
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${aws_autoscaling_group.ecs_asg.name}"
  cooldown               = "300"
  name                   = "${var.environment}-${var.cluster_name}-asg-scaleup-policy"
  scaling_adjustment     = "${var.number_of_instance_to_scale_up}"
  depends_on = ["aws_autoscaling_group.ecs_asg"]
}

##################################################
########            ASG Policy            ########
##################################################
# Scale down policy for ASG
resource "aws_autoscaling_policy" "scale_down_policy" {
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${aws_autoscaling_group.ecs_asg.name}"
  cooldown               = "300"
  name                   = "${var.environment}-${var.cluster_name}-asg-scaledown-policy"
  scaling_adjustment     = "${var.number_of_instance_to_scale_down}"
  depends_on = ["aws_autoscaling_group.ecs_asg"]
}