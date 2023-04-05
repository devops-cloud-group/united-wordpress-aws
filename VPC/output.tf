output "azs" {
  description = "Prints out az names"
  value       = data.aws_availability_zones.available.names
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets"{
  value = [aws_subnet.public_subnet1.id , 
  aws_subnet.public_subnet2.id ,
  aws_subnet.public_subnet3.id]
}

output "private_subnets" {
  value = [aws_subnet.private_subnet1,
  aws_subnet.private_subnet2,
  aws_subnet.private_subnet3]
  
}

output "allow_RDS_sg" {
  value = aws_security_group.allow_RDS_sg.id
}

output "subnet_ids" {
  value = [aws_subnet.private_subnet1.id,
  aws_subnet.private_subnet2.id,
  aws_subnet.private_subnet3.id]
}