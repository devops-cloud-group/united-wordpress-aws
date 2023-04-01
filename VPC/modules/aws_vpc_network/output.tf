output "azs" {
  description = "Prints out az names"
  value       = data.aws_availability_zones.available.names
}

output "vpc_id" {
  value = aws_vpc.main.id
}


output "public_subnets_ids" {
  value = var.public_subnet_cidr_block
}

output "private_subnets_ids" {
  value = var.private_subnet_cidr_block
}