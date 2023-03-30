// find latesst ami
data "aws_ami" "latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.os_version}-*-hvm-*-gp2"]
  }

  owners = ["amazon"]
}

resource "aws_key_pair" "web" {
  key_name   = var.key_name1
  public_key = file(var.public_key)
}

resource "aws_key_pair" "server" {
  key_name   = var.key_name2
  public_key = file(var.public_key)