##################################################
########             Backend              ########
##################################################
# Configure backend remote state with S3
terraform {
  backend "s3" {}
}

##################################################
########                ECS               ########
##################################################
# Create ECS Cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.environment}-${var.cluster_name}"
}

# Write output values to the state file in S3 so that other components can use it
output "ecs_cluster_arn" {
  value = "${aws_ecs_cluster.ecs_cluster.arn}"
}

output "ecs_cluster_id" {
  value = "${aws_ecs_cluster.ecs_cluster.id}"
}

output "ecs_cluster_name" {
  value = "${aws_ecs_cluster.ecs_cluster.name}"
}