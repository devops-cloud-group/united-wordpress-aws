terraform {
  backend "s3" {
    bucket         = "company-wide-tfstate-storage-vpc-group"
    key            = "devops/aws/team/key"
    region         = "us-east-1"
    dynamodb_table = "company-wide-tfstate-vpc"
  }
}