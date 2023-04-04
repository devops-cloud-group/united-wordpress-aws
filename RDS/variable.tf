variable "vpc_id" {}

variable "private_subnet_ids" {
  type = list(any)
}



variable "allow_RDS_sg" {
}

locals {
  readers = length(aws_rds_cluster_instance.reader)
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
  type    = list(string)
  default = [ "subnet-0d050bc5cb23150b7"]
}



