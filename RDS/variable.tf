variable "vpc_id" {}

variable "private_subnet_ids" {
  type = list(any)
  
}

variable "private_subnets"{

}


variable "allow_RDS_sg" {
}


# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

variable "example" {
  type    = string
  default = "example"
}

variable "subnet_ids" {
  
}



