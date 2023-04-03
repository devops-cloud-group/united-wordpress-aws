resource "aws_subnet" "main" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block

  tags = var.tags
}

variable vpc_id {}
variable "cidr_block" {
    default = 10.0.1.0/24"
}
variable "tags" {
    type = map
    default = {
    Name = "Main"
  }
}