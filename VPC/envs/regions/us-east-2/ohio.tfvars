public_key = "~/.ssh/id_rsa.pub"
region     = "us-east-2"
key_name   = "laptop"

tags = {
  Name    = "VPC"
  Team    = "AWS"
}

  vpc_cidr_block  = "10.100.0.0/16"
    public_subnet_1_cidr_block= "10.100.1.0/24"
   public_subnet_2_cidr_block = "10.100.2.0/24"
    public_subnet_3_cidr_block = "10.100.3.0/24"
  private_subnet_1_cidr_block = "10.100.4.0/24"
  private_subnet_2_cidr_block = "10.100.5.0/24"
  private_subnet_3_cidr_block = "10.100.6.0/24"