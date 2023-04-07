#!/bin/bash

git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> ~/.bashrc
source ~/.bashrc 
tfenv  install  1.1.1 
tfenv  use      1.1.1 
terraform version
echo "terraform {
    backend "s3" { 
        bucket = "terraform-tfstate-wordpress"
        key    = "backend/terraform.tfstate"
        region = "us-west-1"
        dynamodb_table = "terraform-prod-lock"
    } 
}" > VPC/backend.tf