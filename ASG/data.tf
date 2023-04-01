# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}



# data "aws_security_groups" "test" {

#   filter {
#     name   = "Wordpress-VPC"
#     values = [data.terraform_remote_state.vpc.outputs.vpc_id]
#   }
# }

# output "aws_security_groups" {
#     value = data.aws_security_groups.test[*]
# }