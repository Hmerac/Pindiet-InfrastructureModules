variable "ext_alb_name" {
  description = "Name of the ALB"
}

variable "environment" {
  description = "Current environment"
}

variable "ext_target_group_name" {
  description = "ALB's target group name"
}

variable "region" {
  description = "Current region"
}

variable "vpc_state_bucket" {
  description = "VPC terraform.state file's bucket name"
}

variable "vpc_state_key" {
  description = "VPC terraform.state file's key name"
}