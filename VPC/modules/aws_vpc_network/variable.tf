

 
variable "region" {
  default = "us-east-1"
}


variable "key_name" {
 // default = "state-vpc-key"
}


variable "public_key" {
// default = "~/.ssh/id_rsa.pub"
}

variable "vpc_cidr_block" {
  //default = "10.100.0.0/16"
  }
variable "public_subnet_cidr_block" {
  //default = ["10.100.1.0/24" , "10.100.2.0/24" , "10.100.3.0/24"]
}

variable "private_subnet_cidr_block" {
  //default = ["10.100.4.0/24" , "10.100.5.0/24" , "10.100.6.0/24"]
}






