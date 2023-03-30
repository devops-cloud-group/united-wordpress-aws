

resource "aws_security_group" "frontend_app_sg" {
  name        = "frontend_app_sg"
  description = "Allow SSH , HTTP and HTTPS inbound  from Frontend app"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "created by Terraform"
  }
}
resource "aws_security_group" "allow_RDS_sg" {
  name        = "allow_RDS_sg"
  description = "Allow  MySQL Port inbound from Backend App Security Group and SSH "
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "created by Terraform"
  }
}


resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "TestVPC"
  }
}




resource "aws_subnet" "public_subnet1" {
  availability_zone       = data.aws_availability_zones.available.names[0]
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1_cidr_block
  map_public_ip_on_launch = true
  tags = {
    Name = "public subnet1"
  }
}


resource "aws_subnet" "public_subnet2" {
  availability_zone       = data.aws_availability_zones.available.names[1]
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2_cidr_block
  map_public_ip_on_launch = true
  tags = {
    Name = "public subnet2"
  }
}

resource "aws_subnet" "public_subnet3" {
  availability_zone       = data.aws_availability_zones.available.names[2]
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_3_cidr_block
  map_public_ip_on_launch = true
  tags = {
    Name = "public subnet3"
  }
}

resource "aws_subnet" "private_subnet1" {
  availability_zone       = data.aws_availability_zones.available.names[0]
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_1_cidr_block
  map_public_ip_on_launch = false
  tags = {
    Name = "private subnet1"
  }
}


resource "aws_subnet" "private_subnet2" {
  availability_zone       = data.aws_availability_zones.available.names[1]
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_2_cidr_block
  map_public_ip_on_launch = false
  tags = {
    Name = "private subnet2"
  }
}

resource "aws_subnet" "private_subnet3" {
  availability_zone       = data.aws_availability_zones.available.names[2]
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_3_cidr_block
  map_public_ip_on_launch = false
  tags = {
    Name = "private subnet3"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "vpc gateway"
  }
}


resource "aws_eip" "eip1" {

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "eip2" {

  depends_on = [aws_internet_gateway.igw]
}
resource "aws_eip" "eip3" {

  depends_on = [aws_internet_gateway.igw]
}

//Created natgw for internet access to my private instances

resource "aws_nat_gateway" "nat_gw1" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.public_subnet1.id

}
resource "aws_nat_gateway" "nat_gw2" {
  allocation_id = aws_eip.eip2.id
  subnet_id     = aws_subnet.public_subnet2.id


}
resource "aws_nat_gateway" "nat_gw3" {
  allocation_id = aws_eip.eip3.id
  subnet_id     = aws_subnet.public_subnet3.id


}
resource "aws_route_table" "public" {
  #The VPC ID
  vpc_id = aws_vpc.main.id

  route {
    # The CIDR block of the route
    cidr_block = "0.0.0.0/0"
    #Identifier of a VPC internet gateway or virtual private gateway
    gateway_id = aws_internet_gateway.igw.id
  }

}

resource "aws_route_table" "private1" {
  #The VPC ID
  vpc_id = aws_vpc.main.id

  route {
    # The CIDR block of the route
    cidr_block = "0.0.0.0/0"
    #Identifier of a VPC  NAT gateway
    nat_gateway_id = aws_nat_gateway.nat_gw1.id
  }

}

resource "aws_route_table" "private2" {
  #The VPC ID
  vpc_id = aws_vpc.main.id

  route {
    # The CIDR block of the route
    cidr_block = "0.0.0.0/0"
    #Identifier of a VPC  NAT gateway
    nat_gateway_id = aws_nat_gateway.nat_gw2.id
  }

}

resource "aws_route_table" "private3" {
  #The VPC ID
  vpc_id = aws_vpc.main.id

  route {
    # The CIDR block of the route
    cidr_block = "0.0.0.0/0"
    #Identifier of a VPC  NAT gateway
    nat_gateway_id = aws_nat_gateway.nat_gw3.id
  }

}


resource "aws_route_table_association" "public1" {
  #The subnet ID to create an association
  subnet_id = aws_subnet.public_subnet1.id

  #The ID of the routing table to associate with
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  #The subnet ID to create an association
  subnet_id = aws_subnet.public_subnet2.id

  #The ID of the routing table to associate with
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public3" {
  #The subnet ID to create an association
  subnet_id = aws_subnet.public_subnet3.id

  #The ID of the routing table to associate with
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private1" {
  #The subnet ID to create an association
  subnet_id = aws_subnet.private_subnet1.id

  #The ID of the routing table to associate with
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "private2" {
  #The subnet ID to create an association
  subnet_id = aws_subnet.private_subnet2.id

  #The ID of the routing table to associate with
  route_table_id = aws_route_table.private2.id
}

resource "aws_route_table_association" "private3" {
  #The subnet ID to create an association
  subnet_id = aws_subnet.private_subnet3.id

  #The ID of the routing table to associate with
  route_table_id = aws_route_table.private3.id
}

