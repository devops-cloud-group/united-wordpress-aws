#!/bin/bash

# installation docs
# https://developer.hashicorp.com/packer/downloads
sudo yum install -y yum-utils shadow-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install packer
packer version

# bash installation.sh 



# learn
# https://developer.hashicorp.com/packer/tutorials