variable "tags" {
  type    = map(any)
  default = {}
}

variable "key_name" {}

variable "public_key" {}

variable "region" {}

<<<<<<< HEAD
variable "vpc_cidr_block" {}
    
=======
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
>>>>>>> main

variable "public_subnet_1_cidr_block" {}
  
variable "public_subnet_2_cidr_block" {}
  
variable "public_subnet_3_cidr_block" {}
  

variable "private_subnet_1_cidr_block" {}
  
variable "private_subnet_2_cidr_block" {}
  
variable "private_subnet_3_cidr_block" {}
  




