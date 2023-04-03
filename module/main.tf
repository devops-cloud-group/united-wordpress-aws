module "vpc" {
  source = "../VPC/"
  public_key = "~/.ssh/id_rsa.pub"
  region     = "eu-west-2"
  key_name   = "laptop"
  }

module "rds" {
  source = "../RDS"
  private_subnet_ids  = module.vpc.private_subnet_ids
  vpc_id = module.vpc.vpc_id
  allow_RDS_sg = module.vpc.allow_RDS_sg
  private_subnets = module.vpc.private_subnets
}

 

