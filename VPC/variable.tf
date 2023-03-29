variable "tags" {
  type    = map(any)
  default = {}


}


variable "region" {}


variable "key_name" {}


variable "public_key" {}

variable "vpc_cidr_block" {}
variable "public_subnet_1_cidr_block" {}
variable "public_subnet_2_cidr_block" {}
variable "public_subnet_3_cidr_block" {}
variable "private_subnet_1_cidr_block" {}
variable "private_subnet_2_cidr_block" {}
variable "private_subnet_3_cidr_block" {}





