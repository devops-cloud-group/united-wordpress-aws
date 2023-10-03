output "azs" {
  description = "Prints out az names"
  value       = data.aws_availability_zones.available.names
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
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

output "security_group_web_id" {
  value = aws_security_group.web.id
}

output "security_group_mysql_id" {
  value = aws_security_group.mysql.id
}

output "env" {
  value = terraform.workspace
}
