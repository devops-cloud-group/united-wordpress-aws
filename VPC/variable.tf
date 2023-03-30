

 variable "env" {
  default = "ohio"
   
 }

variable "region" {
  default =  "us-east-2"
}


variable "key_name" {
  default = "state-vpc-key"
}


variable "public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
  }
variable "public_subnet_cidr_block" {
  default =["10.0.1.0/24" , "10.0.2.0/24" , "10.0.3.0/24"]
}

variable "private_subnet_cidr_block" {
  default = ["10.0.4.0/24" , "10.0.5.0/24" , "10.0.6.0/24"]
}






