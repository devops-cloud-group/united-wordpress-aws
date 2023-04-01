# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

# data "aws_security_group" "web" {
#   id = var.security_group_id
# }

# data "aws_security_group" "mysql" {
#   id = var.security_group_id
# }

# data "aws_security_groups" "test" {
#   filter {
#     name   = "vpc-id"
#     values = [var.vpc_id]
#   }
# }
