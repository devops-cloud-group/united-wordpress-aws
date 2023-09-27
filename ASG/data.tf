# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

data "aws_route53_zone" "selected" {
  name         = var.domain
  private_zone = false
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]

  }
}

data "terraform_remote_state" "backend" {
  backend = "s3"
  config = {
    bucket         = "terraform-tfstate-prod-877868457937"
    key            = "backend/prod/terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "terraform-backend-prod-877868457937"
  }
}
