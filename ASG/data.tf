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

data "aws_security_groups" "test" {}
