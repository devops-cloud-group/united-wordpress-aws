resource "aws_key_pair" "state-vpc" {
  key_name   = var.key_name
  public_key = file(var.public_key)
  
}

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
  
}
# Creates VPC 
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.region}-vpc"
  }
}

# Creates Internet Gateway which is attached to VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
    tags = {
    Name = "${var.region}-igw"
  }
  
}

#Creates  public subnet for each availability zones

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidr_block)
  cidr_block              = element(var.public_subnet_cidr_block, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.region}-public-${count.index + 1}"
  }

}

# Creates  route table for public subnets allows access to internet 
resource "aws_route_table" "public_subnets" {
  #The VPC ID
        vpc_id = aws_vpc.main.id

  route {
    # The CIDR block of the route
    cidr_block = "0.0.0.0/0"
    #Identifier of a VPC internet gateway or virtual private gateway
    gateway_id = aws_internet_gateway.igw.id

    }
    tags = {
    Name = "${var.region}-route-public-subnets"
  }

}
# All Public Subnets are associated with this Route Table
resource "aws_route_table_association" "public_routes" {

  count = length(aws_subnet.public_subnets[*].id)
  #The subnet ID to create an association
  subnet_id = element(aws_subnet.public_subnets[*].id ,count.index)

  #The ID of the routing table to associate with
  route_table_id = aws_route_table.public_subnets.id
  
}

# Creates Elastic IP for each Nat Gateway depends on quantity of private subnets
resource "aws_eip" "nat" {
  count = length(var.private_subnet_cidr_block)
   vpc =true
   tags = {
    Name = "${var.region}-nat-gw-${count.index +1}"
  }
}

# Creates Nat Gateway  depends on quantity of private subnets
resource "aws_nat_gateway" "nat_gw" {
  count         = length(var.private_subnet_cidr_block)
  allocation_id = aws_eip.nat[count.index].id 
  subnet_id     = element(aws_subnet.public_subnets[*].id ,count.index)
  tags = {
    Name = "${var.region}-nat-gw-${count.index + 1}"
  }

}



# Creates Private Subnets for each availability zones
resource "aws_subnet" "private_subnets" {
  count                   = length(var.private_subnet_cidr_block)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.private_subnet_cidr_block, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.region}-private-${count.index + 1}"
  }

}

# Creates Route table for private subnets
resource "aws_route_table" "private_subnets" {
  #The VPC ID
  count = length(var.private_subnet_cidr_block)
       vpc_id = aws_vpc.main.id

  route {
    # The CIDR block of the route
    cidr_block = "0.0.0.0/0"
    #Identifier of a VPC  NAT gateway
    gateway_id = aws_nat_gateway.nat_gw[count.index].id
  }
  tags = {
    Name = "${var.region}-route-private-subnet-${count.index}"
  }

}

# All Private Subnets are associated with this public subnets
resource "aws_route_table_association" "private_routes" {
  count = length(aws_subnet.private_subnets[*].id)
  #The subnet ID to create an association
  subnet_id =  element(aws_subnet.private_subnets[*].id , count.index)

  #The ID of the routing table to associate with
  route_table_id =aws_route_table.private_subnets[count.index].id 
  }

