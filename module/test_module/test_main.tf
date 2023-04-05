module "ohio_vpc" {
  source                    = "../../VPC"
  region                    = "us-east-2"
  key_name                  = "state-vpc-key"
  public_key                = "~/.ssh/id_rsa.pub"
  vpc_cidr_block            = "10.100.0.0/16"
  
  public_subnet_1_cidr_block = "10.100.1.0/24"
  public_subnet_2_cidr_block = "10.100.2.0/24"
  public_subnet_3_cidr_block = "10.100.3.0/24"

  private_subnet_1_cidr_block = "10.100.4.0/24"
  private_subnet_2_cidr_block = "10.100.5.0/24"
  private_subnet_3_cidr_block = "10.100.6.0/24"
}

module "ohio_RDS"{
  source = "../../RDS"
  vpc_id = module.ohio_vpc.vpc_id
  allow_RDS_sg = module.ohio_vpc.allow_RDS_sg
 subnet_ids = module.ohio_vpc.subnet_ids
}

