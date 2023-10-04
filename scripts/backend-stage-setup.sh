#!/bin/bash

# Get the AWS account ID
export ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

# Directories and their corresponding S3 paths
dirs=("VPC" "ASG" "RDS")
keys=("network/terraform.tfstate" "servers/terraform.tfstate" "database/terraform.tfstate")

# Loop through directories and keys
for i in "${!dirs[@]}"; do
    dir=${dirs[$i]}
    key=${keys[$i]}
    
    echo "terraform {
      backend \"s3\" {
        bucket         = \"terraform-tfstate-stage-$ACCOUNT_ID\"
        dynamodb_table = \"terraform-backend-stage-lock\"
        key            = \"$key\"
        region         = \"us-west-1\"
      }
    }" > "$dir/backend.tf"
done
