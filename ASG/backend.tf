terraform {
    backend "s3" {
        bucket = "terraform-tfstate-storage-wordpress"
        key    = "terraform.tfstate"
        region = "us-west-1"
        dynamodb_table = "terraform-state-lock"
    } 
}
