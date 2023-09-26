#!/bin/bash

echo "terraform {
  backend \"s3\" {
    bucket         = \"terraform-tfstate-prod-$ACCOUNT_ID\"
    key            = \"backend/prod/terraform.tfstate\"
    region         = \"us-west-1\"
    dynamodb_table = \"terraform-backend-prod-$ACCOUNT_ID\"
  }
}" > VPC/backend-prod.tf