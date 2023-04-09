variable "tags" {
  type    = map(any)
  default = {}
}

variable "key_name" {}

variable "public_key" {}
variable "rds_username" {
  description = "Database administrator username"
  type        = string
  sensitive   = true
}
variable "rds_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

variable "region" {}
variable "domain" {}

variable "random_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}
# variable "vpc_id" {}

# variable "aws_security_group" {
#   filter {
#     name   = "vpc-id"
#     values = [var.vpc_id]
#   }
# }
  
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
    ]
}

variable "private_subnets" {
  default = [
    "10.0.11.0/24",
    "10.0.12.0/24",
    "10.0.13.0/24"
    ]
}


data "aws_route53_zone" "selected" {
  name = var.domain
}


locals {
  readers = length(aws_rds_cluster_instance.db_instance[*])
  
}


