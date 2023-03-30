

public_key = "~/.ssh/id_rsa.pub"
region     = "ap-southeast-1"
key_name   = "state-vpc-key"



vpc_cidr_block = "192.168.0.0/16"
public_subnet_cidr_block = ["192.168.1.0/24" , "192.168.2.0/24" , "192.168.3.0/24"]


private_subnet_cidr_block = ["192.168.4.0/24" , "192.168.5.0/24" ,"192.168.6.0/24"]
