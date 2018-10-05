variable "region" {
  description = "AWS Region of the ECS Cluster"
  default     = "eu-central-1"
}

variable "environment" {
  description = "Environment of the ECS i.e. Development"
}

variable "cluster_name" {
  description = "Name of the ECS Cluster"
}