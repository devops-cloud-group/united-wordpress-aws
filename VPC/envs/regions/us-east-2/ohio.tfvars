
public_key = "~/.ssh/id_rsa.pub"
region     = "us-east-2"
key_name   = "state-vpc-key"

tags = {
  Name    = "VPC"
  Team    = "AWS"
  Quarter = 2
}



vpc_cidr_block = "10.0.0.0/16"
public_subnet_1_cidr_block = "10.0.1.0/24"
public_subnet_2_cidr_block = "10.0.2.0/24"
public_subnet_3_cidr_block = "10.0.3.0/24"


private_subnet_1_cidr_block = "10.0.4.0/24"
private_subnet_2_cidr_block = "10.0.5.0/24"
private_subnet_3_cidr_block = "10.0.6.0/24"


