variable "vpc_name" {
  description = "Name of the VPC"
}

variable "vpc_cidr_block" {
  description = "IP range of VPC"
}

variable "environment" {
  description = "Current environment"
}

variable "public_subnets_cidr" {
  type        = "list"
  description = "IP ranges of public subnets"
}

variable "private_subnets_cidr" {
  type        = "list"
  description = "IP ranges of private subnets"
}

variable "availability_zones" {
  type        = "list"
  description = "Selected availability zones(Probably two for cost cutting)"
}