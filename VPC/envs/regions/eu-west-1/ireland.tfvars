

public_key = "~/.ssh/id_rsa.pub"
region     = "eu-west-1"
key_name   = "state-vpc-key"

tags = {
  Name    = "VPC"
  Team    = "AWS"
  Quarter = 2
}

vpc_cidr_block = "172.16.0.0/16"
public_subnet_1_cidr_block = "172.16.1.0/24"
public_subnet_2_cidr_block = "172.16.2.0/24"
public_subnet_3_cidr_block = "172.16.3.0/24"
private_subnet_1_cidr_block = "172.16.4.0/24"
private_subnet_2_cidr_block = "172.16.5.0/24"
private_subnet_3_cidr_block = "172.16.6.0/24"


  


