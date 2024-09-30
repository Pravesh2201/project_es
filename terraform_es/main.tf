provider "aws" {
  region = "us-east-1"
}

# VPC Module
module "vpc" {
  source  = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "my-vpc"
}

# Subnet Module
module "subnet" {
  source              = "./modules/subnet"
  vpc_id              = module.vpc.vpc_id
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  az                  = "us-east-1a"
}

# NAT Gateway Module
module "nat_gateway" {
  source          = "./modules/nat_gateway"
  public_subnet_id = module.subnet.public_subnet_id
}

# Route Table Module
module "route_table" {
  source              = "./modules/route_table"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id
  nat_gateway_id      = module.nat_gateway.nat_gateway_id
  public_subnet_id    = module.subnet.public_subnet_id
  private_subnet_id   = module.subnet.private_subnet_id
}

# Security Group Module
module "security_group" {
  source  = "./modules/security_group"
  vpc_id  = module.vpc.vpc_id
  vpc_cidr = "10.0.0.0/16"
}

# EC2 Module
module "ec2" {
  source             = "./modules/ec2"
  ami_id             = "ami-0a0e5d9c7acc336f1"
  key_name           = "AWS"
  public_subnet_id   = module.subnet.public_subnet_id
  private_subnet_id  = module.subnet.private_subnet_id
  public_sg_id = module.security_group.public_sg_id
  private_sg_id = module.security_group.private_sg_id
  public_instance = var.associate_public_ip_address


}


