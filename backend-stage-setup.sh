#!/bin/bash

echo "terraform {
  backend \"s3\" {
    bucket         = \"terraform-tfstate-stage-$ACCOUNT_ID\"
    key            = \"backend/stage/terraform.tfstate\"
    region         = \"us-west-1\"
    dynamodb_table = \"terraform-backend-stage-$ACCOUNT_ID\"
  }
}" > VPC/backend-stage.tf