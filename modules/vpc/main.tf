resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  tags = var.tags
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "tags" {
  type = map
  default = {
    Name = "main"
  }
}

ouput vpc_id {
    value = aws_vpc.main.id
}