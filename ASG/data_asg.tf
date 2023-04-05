# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

data "terraform_remote_state" "vpc" {
    backend = "s3" 
    config = {
    bucket         = "company-wide-tfstate-storage-vpc-group"
    key            = "devops/aws/team/key"
    region         = "us-east-1"
    dynamodb_table = "company-wide-tfstate-vpc"
    } 
}

data "terraform_remote_state" "asg" {
    backend = "s3" 
    config = {
    bucket         = "company-wide-tfstate-storage-vpc-group"
    key            = "devops/aws/team/key"
    region         = "us-east-1"
    dynamodb_table = "company-wide-tfstate-vpc"
    } 
}


# data "aws_security_groups" "test" {

#   filter {
#     name   = "Wordpress-VPC"
#     values = [var.vpc_id]
#   }
# }

# output "aws_security_groups" {
#     value = data.aws_security_groups.test[*]
# }