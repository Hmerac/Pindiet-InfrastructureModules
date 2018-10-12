variable "environment" {
  description = "Current environment"
}

variable "vpc_state_bucket" {
  description = "VPC terraform.state file's bucket name"
}

variable "vpc_state_key" {
  description = "VPC terraform.state file's key name"
}

variable "region" {
  description = "Current region"
}

variable "cluster_name" {
  description = "Name of the ECS Cluster"
}

variable "schedulable_containers_high_evaluation_periods" {
  description = "Evaluation period for high point of Schedulable Containers"
}

variable "schedulable_containers_low_evaluation_periods" {
  description = "Evaluation period for high point of Schedulable Containers"
}

variable "metric_name" {
  description = "Metric name in Cloudwatch"
}

variable "schedulable_containers_high_period" {
  description = "Period for high point of Schedulable Containers"
}

variable "schedulable_containers_low_period" {
  description = "Period for low point of Schedulable Containers"
}

variable "statistic_type" {
  description = "Statistic of metric"
}

variable "schedulable_containers_high_threshold" {
  description = "Threshold for low point of Schedulable Containers"
}

variable "schedulable_containers_low_threshold" {
  description = "Threshold for low point of Schedulable Containers"
}

variable "number_of_instance_to_scale_up" {
  description = "How many instances to boot when scaling up"
}

variable "number_of_instance_to_scale_down" {
  description = "How many instances to boot when scaling down"
}

variable "namespace" {
  description = "Namespace for Cloudwatch"
}

variable "handler" {
  description = "Handler for Lambda"
}

variable "runtime" {
  description = "Runtime of Lambda script"
}

variable "timeout" {
  description = "Timeout value for Lambda script"
}

variable "memory_size" {
  description = "Memory size of Lambda script"
}

variable "min_instance_num" {
  description = "Minimum number of instances to be running"
}

variable "max_instance_num" {
  description = "Maximum number of instances to be running"
}

variable "desired_instance_num" {
  description = "Desired number of instances to be running"
}

variable "instance_type" {
  description = "Instance type"
}

variable "ecs_keypair_name" {
  description = "Keypair name of the ECS Instances to SSH"
}