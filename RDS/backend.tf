terraform {
  backend "s3" {
    bucket = "company-wide-tfstate-storage-stanislav4907"
    key    = "path/to/my/vpc"
    region = "us-east-1"
   
  }
}