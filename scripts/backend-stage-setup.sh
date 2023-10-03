#!/bin/bash

# Get the AWS account ID
export ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

# Declare an associative array where the key is the directory and the value is the S3 key
declare -A paths
paths=( ["VPC"]="network/terraform.tfstate"
    ["ASG"]="servers/terraform.tfstate"
["RDS"]="database/terraform.tfstate" )

# Loop through each key-value pair in the associative array
for dir in "${!paths[@]}"; do
    echo "terraform {
      backend \"s3\" {
        bucket         = \"terraform-tfstate-stage-$ACCOUNT_ID\"
        dynamodb_table = \"terraform-backend-stage-$ACCOUNT_ID\"
        key            = \"${paths[$dir]}\"
        region         = \"${var.region}\"
      }
    }" > "$dir/backend.tf"
done