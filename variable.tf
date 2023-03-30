variable "db_name" {
  default = "dbserveron"
}
variable "db_user" {
  default = "administrator"
}
variable "db_password" {
  default = "my$qlser7We6"
}
variable "tags" {

  default = "created by Terraform"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "region" {
  default = "us-east-1"
}



variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "public_subnet_1_cidr_block" {
  default = "10.0.1.0/24"
}

variable "public_subnet_2_cidr_block" {
  default = "10.0.2.0/24"

}
variable "public_subnet_3_cidr_block" {
  default = "10.0.3.0/24"
}
variable "private_subnet_1_cidr_block" {
  default = "10.0.7.0/24"
}
variable "private_subnet_2_cidr_block" {
  default = "10.0.8.0/24"
}
variable "private_subnet_3_cidr_block" {
  default = "10.0.9.0/24"
}





