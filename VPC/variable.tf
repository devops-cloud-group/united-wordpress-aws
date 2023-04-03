variable "tags" {
  type    = map(any)
  default = {}
}

variable "key_name" {}

variable "public_key" {}

variable "region" {}

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




