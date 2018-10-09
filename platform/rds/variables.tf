variable "vpc_name" {
  description = "Name of the VPC"
}

variable "environment" {
  description = "Current environment"
}

variable "availability_zones" {
  type        = "list"
  description = "Selected availability zones(Probably two for cost cutting)"
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

variable "allocated_storage" {
  description = "Storage size in GiBs"
}

variable "instance_class" {
  description = "RDS instance type"
}

variable "multi_az" {
  description = "Whether AZ true or not"
}

variable "database_name" {
  description = "RDS DB name"
}

variable "database_username" {
  description = "RDS master username"
}

variable "database_password" {
  description = "RDS master password"
}