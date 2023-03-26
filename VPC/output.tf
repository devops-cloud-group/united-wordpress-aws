output azs {
  description = "Prints out az names"
  value = data.aws_availability_zones.available.names
}