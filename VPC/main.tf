resource "aws_key_pair" "state-vpc" {
  key_name   = var.key_name
  public_key = file(var.public_key)
  tags       = var.tags
}

resource "aws_security_group" "important" {
  name        = "important"
  description = "Allow TLS inbound traffic"
  vpc_id = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}


resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags       = var.tags
}


resource "aws_subnet" "pub_subnet1" {
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id  = aws_vpc.main.id
  cidr_block = var.public_subnet_1_cidr_block
}


resource "aws_subnet" "pub_subnet2" {
  availability_zone = data.aws_availability_zones.available.names[1]
  vpc_id  = aws_vpc.main.id
  cidr_block = var.public_subnet_2_cidr_block
}

resource "aws_subnet" "pub_subnet3" {
  availability_zone = data.aws_availability_zones.available.names[2]
  vpc_id  = aws_vpc.main.id
  cidr_block = var.public_subnet_3_cidr_block
}