##################################################
########              IAM Role            ########
##################################################
# Create IAM Assume Role for ECS Autoscaling Lambda
resource "aws_iam_role" "ecs_autoscale_role" {
  name               = "${var.environment}-ecs-autoscale-role"
  assume_role_policy = "${file("${path.module}/policies/lambda-role.json")}"
}

##################################################
########             IAM Policy           ########
##################################################
# Create IAM Policy for ECS Autoscaling Lambda
resource "aws_iam_role_policy" "ecs_autoscale_policy" {
  name   = "ecs_autoscale_policy"
  policy = "${file("${path.module}/policies/lambda-role-policy.json")}"
  role   = "${aws_iam_role.ecs_autoscale_role.id}"
}

##################################################
########              IAM Role            ########
##################################################
# Create IAM Assume Role for ECS Instances
resource "aws_iam_role" "cluster-role" {
  name = "ms-${var.cluster_name}-role"

  assume_role_policy = "${file("${path.module}/policies/ecs-autoscale-role.json")}"
}

##################################################
########             IAM Policy           ########
##################################################
# Create IAM Policy for ECS Instances
resource "aws_iam_role_policy" "cluster-policy" {
  name = "ms-ecs-${var.cluster_name}-role"
  role = "${aws_iam_role.cluster-role.id}"

  policy = "${file("${path.module}/policies/ecs-autoscale-role-policy.json")}"
}

##################################################
########        IAM Instance Profile      ########
##################################################
# Create IAM Instance Profile for ECS Instances
resource "aws_iam_instance_profile" "cluster-profile" {
  name = "ms-${var.cluster_name}-profile"
  role = "${aws_iam_role.cluster-role.name}"
}