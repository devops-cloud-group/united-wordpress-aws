output "azs" {
  description = "Prints out az names"
  value       = data.aws_availability_zones.available.names
}

output "vpc_id" {
  value = aws_vpc.main.id
}
