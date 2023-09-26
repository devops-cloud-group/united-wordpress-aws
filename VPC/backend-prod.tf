terraform {
  backend "s3" {
    bucket         = "terraform-tfstate-prod-877868457937"
    key            = "backend/prod/terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "terraform-backend-prod-877868457937"
  }
}
