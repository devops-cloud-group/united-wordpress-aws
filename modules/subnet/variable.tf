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