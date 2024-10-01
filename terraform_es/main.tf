provider "aws" {
  region = var.region
}

module "vpc" {
  source       = "./vpc"
  cidr_block   = "10.0.0.0/16"
  public_cidr  = "10.0.1.0/24"
  private_cidr = "10.0.2.0/24"
}

module "ec2" {
  source            = "./ec2"
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  bastion_sg_id     = module.vpc.bastion_sg_id
  private_sg_id     = module.vpc.private_sg_id
  key_name          = var.key_name
}

module "vpc_peering" {
  source                = "./vpc_peering"
  vpc_id                = module.vpc.vpc_id
  peer_vpc_id           = var.peer_vpc_id
  public_route_table_id = module.vpc.public_route_table_id
  private_route_table_id = module.vpc.private_route_table_id
  existing_route_table_id = "rtb-03cd977d679675f4f"
  peer_vpc_cidr_block = "172.31.0.0/16"
}

