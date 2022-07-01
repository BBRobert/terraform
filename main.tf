
module "networking" {
  source = "./modules/networking"

  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  availability_zones = local.availability_zones
}


module "backend" {
  source = "./modules/instances"

  environment    = var.environment
  instance_group = "backend"

  subnets_id          = module.networking.private_subnets_id
  vpc_id              = module.networking.vpc_id
  security_groups_ids = module.networking.security_groups_ids

  ec2_template         = aws_launch_template.ec2
  asg_desired_capacity = var.be_asg_desired_capacity
  asg_max_size         = var.be_asg_max_size
  asg_min_size         = var.be_asg_min_size

  do_create_lb = var.do_create_be_lb
}


module "frontend" {
  source = "./modules/instances"

  environment    = var.environment
  instance_group = "frontend"

  subnets_id          = module.networking.public_subnets_id
  vpc_id              = module.networking.vpc_id
  security_groups_ids = module.networking.security_groups_ids

  ec2_template         = aws_launch_template.ec2
  asg_desired_capacity = var.fe_asg_desired_capacity
  asg_max_size         = var.fe_asg_max_size
  asg_min_size         = var.fe_asg_min_size

  do_create_lb = var.do_create_fe_lb
}