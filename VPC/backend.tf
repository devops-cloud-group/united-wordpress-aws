terraform {
  backend "s3" {
    bucket = "company-wide-tfstate-storage-stanislav4907"
    key    = "path/to/my/key"
    region = "us-east-1"
    dynamodb_table = "company-wide-tfstate"
  }
}