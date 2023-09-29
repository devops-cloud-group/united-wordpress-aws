# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_caller_identity" "current" {}


data "aws_security_group" "web" {
  id = aws_security_group.web.id
}

data "aws_security_group" "mysql" {
  id = aws_security_group.mysql.id
}
