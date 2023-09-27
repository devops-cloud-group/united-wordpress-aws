data "aws_route53_zone" "selected" {
  name         = var.domain
  private_zone = false
}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "terraform_remote_state" "backend" {
  backend = "s3"
  config = {
    bucket         = "terraform-tfstate-${terraform.workspace}-${data.aws_caller_identity.current.account_id}"
    key            = "backend/${terraform.workspace}/terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "terraform-backend-${terraform.workspace}-${data.aws_caller_identity.current.account_id}"
  }
}
