resource "aws_key_pair" "state-vpc" {
  key_name   = var.key_name
  public_key = file(var.public_key)
  tags       = var.tags
}

