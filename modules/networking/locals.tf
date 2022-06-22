locals {
  number_subnets        = length(var.availability_zones)
  newbits               = [for s in range(2*local.number_subnets) : 4]
  cidr_subnets          = cidrsubnets(flatten([var.vpc_cidr,local.newbits])...)
  public_subnets_cidr   = chunklist(local.cidr_subnets,local.number_subnets)[0]
  private_subnets_cidr  = chunklist(local.cidr_subnets,local.number_subnets)[1]
}