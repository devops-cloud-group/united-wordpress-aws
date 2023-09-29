#!/bin/bash


export ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
echo "terraform {
  backend \"s3\" {
    bucket         = \"terraform-tfstate-prod-$ACCOUNT_ID\"
    dynamodb_table = \"terraform-backend-prod-$ACCOUNT_ID\"
    key            = \"network/terraform.tfstate\"
    region         = \"us-west-1\"
    }
}" > VPC/backend.tf

echo "terraform {
  backend \"s3\" {
    bucket         = \"terraform-tfstate-prod-$ACCOUNT_ID\"
    dynamodb_table = \"terraform-backend-prod-$ACCOUNT_ID\"
    key            = \"servers/terraform.tfstate\"
    region         = \"us-west-1\"
  }
}" > ASG/backend.tf

echo "terraform {
  backend \"s3\" {
    bucket         = \"terraform-tfstate-prod-$ACCOUNT_ID\"
    dynamodb_table = \"terraform-backend-prod-$ACCOUNT_ID\"
    key            = \"database/terraform.tfstate\"
    region         = \"us-west-1\"
  }
}" > RDS/backend.tf