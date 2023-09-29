
provider "aws" {
  region = var.region
}

resource "aws_security_group" "web" {
  name        = "frontend_app_sg"
  description = "Allow SSH , HTTP and HTTPS inbound  from Frontend app"
  vpc_id      = aws_vpc.main.id
  dynamic "ingress" {
    for_each = ["80", "443", "22"]
    content {
      description = "TLS from VPC"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
resource "aws_security_group" "mysql" {
  description = "Allow  MySQL Port inbound from Backend App Security Group and SSH "
  vpc_id      = aws_vpc.main.id
  name        = "database_security_group"
  ingress {
    description = "mysql"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    #TODO: change this to the security group of the mysql server
    # cidr_blocks = ["10.0.0.0/16"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = var.tags
}

resource "aws_subnet" "public_subnets" {
  count = length(data.aws_availability_zones.available.names)
  # count                   = 3
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnets, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "public-${count.index + 1}"
  }
}


resource "aws_subnet" "private_subnets" {
  count = length(data.aws_availability_zones.available.names)
  # count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.private_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "private-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Internet GW"
  }
}

resource "aws_eip" "eip" {
  count      = length(aws_subnet.public_subnets[*].id)
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "NAT-${count.index + 1}-ElasticIP"
  }
}

//Created natgw for internet access to my private instances

resource "aws_nat_gateway" "nat_gw" {
  count         = length(aws_subnet.public_subnets[*].id)
  allocation_id = element(aws_eip.eip[*].id, count.index)
  subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)
  tags = {
    Name = "NAT GW-${count.index + 1}"
  }
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

resource "aws_route_table" "private" {
  count = length(aws_subnet.private_subnets[*].id)
  #The VPC ID
  vpc_id = aws_vpc.main.id

  route {
    # The CIDR block of the route
    cidr_block = "0.0.0.0/0"
    #Identifier of a VPC  NAT gateway
    nat_gateway_id = element(aws_nat_gateway.nat_gw[*].id, count.index)
  }

}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public_subnets[*].id)
  #The subnet ID to create an association
  subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
  #The ID of the routing table to associate with
  route_table_id = element(aws_route_table.public[*].id, count.index)
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private_subnets[*].id)
  #The subnet ID to create an association
  subnet_id = element(aws_subnet.private_subnets[*].id, count.index)
  #The ID of the routing table to associate with
  route_table_id = element(aws_route_table.private[*].id, count.index)
}


