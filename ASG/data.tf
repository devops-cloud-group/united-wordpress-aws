# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

data "terraform_remote_state" "vpc" {
    backend = "s3" 
    config = {
        bucket = "terraform-tfstate-storage-wordpress"
        key    = "vpc/terraform.tfstate"
        region = "us-west-1"
        dynamodb_table = "terraform-state-lock"
    } 
}

data "terraform_remote_state" "asg" {
    backend = "s3" 
    config = {
        bucket = "terraform-tfstate-storage-wordpress"
        key    = "asg/terraform.tfstate"
        region = "us-west-1"
        dynamodb_table = "terraform-state-lock"
    } 
}


data "aws_security_groups" "test" {

  filter {
    name   = "Wordpress-VPC"
    values = [data.terraform_remote_state.asg.outputs.vpc_id]
  }
}

output "aws_security_groups" {
    value = data.aws_security_groups.test[*]
}