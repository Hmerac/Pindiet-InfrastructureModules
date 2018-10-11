variable "environment" {
  description = "Current environment"
}

variable "vpc_state_bucket" {}

variable "vpc_state_key" {}

variable "min_capacity" {}

variable "max_capacity" {}

variable "region" {}

variable "cluster_name" {}

variable "schedulable_containers_high_evaluation_periods" {}

variable "schedulable_containers_low_evaluation_periods" {}

variable "metric_name" {}

variable "schedulable_containers_high_period" {}

variable "schedulable_containers_low_period" {}

variable "statistic_type" {}

variable "schedulable_containers_high_threshold" {}

variable "schedulable_containers_low_threshold" {}

variable "number_of_instance_to_scale_up" {}

variable "number_of_instance_to_scale_down" {}

variable "namespace" {}