#!/bin/bash
git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> ~/.bashrc
source ~/.bashrc
tfenv  install  1.5.7
tfenv  use      1.5.7
terraform version

export ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

# Directories and their corresponding S3 paths
dirs=("S3-Backend" "VPC" "ASG" "RDS")
keys=("network/terraform.tfstate" "servers/terraform.tfstate" "database/terraform.tfstate")

# Loop through directories and keys
for i in "${!dirs[@]}"; do
    dir=${dirs[$i]}
    key=${keys[$i]}
    
    echo "terraform {
      backend \"s3\" {
        bucket         = \"terraform-tfstate-prod-$ACCOUNT_ID\"
        dynamodb_table = \"terraform-backend-prod-$ACCOUNT_ID\"
        key            = \"$key\"
        region         = "var.region"
      }
    }" > "$dir/backend.tf"
done

