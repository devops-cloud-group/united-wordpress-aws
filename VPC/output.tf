output "azs" {
  description = "Prints out az names"
  value       = data.aws_availability_zones.available.names
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "private_subnet_cidrs" {
  value = aws_subnet.private_subnets[*].cidr_block
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "public_subnet_cidrs" {
  value = aws_subnet.public_subnets[*].cidr_block
}


output "allow_RDS_sg" {
  value = aws_security_group.allow_RDS_sg.name
}


output "private_subnets" {

 value = aws_subnet.private_subnets[*].id
}

