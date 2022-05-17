
locals {
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}

module "networking" {
  source = "./modules/networking"

  region               = "${var.region}"
  environment          = "${var.environment}"
  vpc_cidr             = "${var.vpc_cidr}"
  public_subnets_cidr  = "${var.public_subnets_cidr}"
  private_subnets_cidr = "${var.private_subnets_cidr}"
  availability_zones   = "${local.availability_zones}"
}


module "instances" {
  source = "./modules/instances"
  
  environment       = "${var.environment}"
  public_subnets_id = module.networking.public_subnets_id
  vpc_id            = module.networking.vpc_id
  security_group_id = module.networking.default_sg_id
}