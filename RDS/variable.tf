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

variable "zone_id" {
  default = "Z1QD9857MPKBV2"
}





