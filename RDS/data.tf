data "aws_route53_zone" "selected" {
  name         = var.domain
  private_zone = false
}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "terraform_remote_state" "servers" {
  backend = "s3"
  config = {
    bucket         = "terraform-tfstate-${terraform.workspace}-${data.aws_caller_identity.current.account_id}"
    key            = "env:/prod/servers/terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "terraform-backend-${terraform.workspace}-${data.aws_caller_identity.current.account_id}"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket         = "terraform-tfstate-${terraform.workspace}-${data.aws_caller_identity.current.account_id}"
    key            = "env:/prod/network/terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "terraform-backend-${terraform.workspace}-${data.aws_caller_identity.current.account_id}"
  }
}

