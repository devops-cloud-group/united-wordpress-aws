terraform {
    backend "s3" {
        bucket = "terraform-tfstate-storage-wordpress"
        key    = "vpc/terraform.tfstate"
        region = "us-west-1"
        dynamodb_table = "terraform-state-lock"
    } 
}
