variable "environment" {
  description = "Current environment"
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

variable "bastion_name" {
  description = "Name of the Bastion"
}

variable "bastion_keypair_name" {
  description = "Keypair name of the Bastion to SSH"
}