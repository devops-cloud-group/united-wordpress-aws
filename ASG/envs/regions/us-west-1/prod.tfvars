public_key = "~/.ssh/id_rsa.pub"
region     = "us-west-1"
key_name   = "laptop"

tags = {
  Name    = "VPC"
  Team    = "AWS"
}

vpc_cidr_block = "172.16.0.0/16"
public_subnet_1_cidr_block = "172.16.1.0/24"
public_subnet_2_cidr_block = "172.16.2.0/24"
public_subnet_3_cidr_block = "172.16.3.0/24"
private_subnet_1_cidr_block = "172.16.11.0/24"
private_subnet_2_cidr_block = "172.16.12.0/24"
private_subnet_3_cidr_block = "172.16.13.0/24"