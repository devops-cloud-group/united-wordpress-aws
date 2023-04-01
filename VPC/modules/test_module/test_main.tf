

module "viginia_vpc" {
  source                    = "../aws_vpc_network"
  region                    = "us-east-1"
  key_name                  = "state-vpc-key"
  public_key                = "~/.ssh/id_rsa.pub"
  vpc_cidr_block            = "10.100.0.0/16"
  public_subnet_cidr_block  = ["10.100.1.0/24", "10.100.2.0/24", "10.100.3.0/24"]
  private_subnet_cidr_block = ["10.100.4.0/24", "10.100.5.0/24", "10.100.6.0/24"]
}

module "london_vpc" {
  source                    = "../aws_vpc_network"
  region                    = "eu-west-2"
  key_name                  = "state-vpc-key"
  public_key                = "~/.ssh/id_rsa.pub"
  vpc_cidr_block            = "10.10.0.0/16"
  public_subnet_cidr_block  = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  private_subnet_cidr_block = ["10.10.11.0/24", "10.10.22.0/24", "10.10.33.0/24"]
}


module "california_vpc" {
  source                    = "../aws_vpc_network"
  region                    = "us-west-1"
  key_name                  = "state-vpc-key"
  public_key                = "~/.ssh/id_rsa.pub"
  vpc_cidr_block            = "10.200.0.0/16"
  public_subnet_cidr_block  = ["10.200.1.0/24", "10.200.2.0/24"]
  private_subnet_cidr_block = ["10.200.11.0/24", "10.200.22.0/24"]
}
