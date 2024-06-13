locals {
  name = "${var.name}-${random_string.suffix.result}"
}

################################################################################
# VPC
################################################################################

variable "name" {
  description = "Name"
  type        = string
  default     = "consul-ecs-demo"
}

variable "vpc_region" {
  type        = string
  description = "The AWS region to create resources in"
  default     = "us-east-1"
}


################################################################################
# EC2 Instance
################################################################################

variable "consul_server_count" {
  type = number
  description = "Number of Consul Servers"
  default = 1
}

variable "instance_type" {

}

variable "ami" {

}

variable "key_name" {

}

variable "ssh_user" {

}

variable "private_key_path" {

}

/****

################################################################################
# Consul
################################################################################

variable "consul_version" {
  type        = string
  description = "The Consul version"
  default     = "1.17.0"
}

variable "chart_version" {
  type        = string
  description = "The Consul Helm chart version to use"
  default     = "1.3.0"
}

variable "datacenter" {
  type        = string
  description = "The name of the Consul datacenter that client agents should register as"
  default     = "dc1"
}

*****/
################################################################################
# Other
################################################################################

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

