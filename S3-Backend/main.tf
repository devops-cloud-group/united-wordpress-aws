provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "terraform-tfstate-${terraform.workspace}-${data.aws_caller_identity.current.account_id}"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}


resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "terraform-backend-${terraform.workspace}-lock"
  hash_key       = "LockID"
  read_capacity  = 10
  write_capacity = 10

  attribute {
    name = "LockID"
    type = "S"
  }
}
