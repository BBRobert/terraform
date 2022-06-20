
locals {
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}

module "networking" {
  source = "./modules/networking"

  region               = var.region
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = local.availability_zones
}

data "aws_ami" "amazon_linux" {
    most_recent = true
    owners      = ["amazon"]    
    filter {
        name    = "name"
        values  = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}

resource "aws_launch_template" "ec2" {
  name                   = "${var.environment}-ec2-template"
  image_id               = data.aws_ami.amazon_linux.id
  instance_type          = var.ec2_instance_type
  user_data              = filebase64(var.ec2_user_data_file)
  vpc_security_group_ids = module.networking.security_groups_ids

  tag_specifications {
    resource_type = "instance"

    tags = {
      Environment = "${var.environment}"
      Name        = "${var.environment}-ec2-instance"
    }
  }
}


module "backend" {
  source = "./modules/instances"

  environment             = var.environment
  instance_group          = "backend"

  public_subnets_id       = module.networking.public_subnets_id
  vpc_id                  = module.networking.vpc_id
  security_groups_ids     = module.networking.security_groups_ids

  ec2_template            = aws_launch_template.ec2
  asg_desired_capacity    = var.be_asg_desired_capacity
  asg_max_size            = var.be_asg_max_size
  asg_min_size            = var.be_asg_min_size

  do_create_lb            = var.do_create_be_lb
}


module "frontend" {
  source = "./modules/instances"

  environment             = var.environment
  instance_group          = "frontend"

  public_subnets_id       = module.networking.public_subnets_id
  vpc_id                  = module.networking.vpc_id
  security_groups_ids     = module.networking.security_groups_ids

  ec2_template            = aws_launch_template.ec2
  asg_desired_capacity    = var.fe_asg_desired_capacity
  asg_max_size            = var.fe_asg_max_size
  asg_min_size            = var.fe_asg_min_size

  do_create_lb            = var.do_create_fe_lb
}