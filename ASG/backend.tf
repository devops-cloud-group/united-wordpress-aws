terraform {
    backend "s3" {
        bucket = "terraform-tfstate-wordpress"
        key    = "backend/terraform.tfstate"
        region = "us-west-1"
        dynamodb_table = "terraform-prod-lock"
    } 
}
