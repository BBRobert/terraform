variable "region" {
  description = "Region"
}

variable "environment" {
  description = "The Deployment environment"
}

//Networking
variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
}

variable "public_subnets_cidr" {
  type        = list
  description = "The CIDR block for the public subnet"
}

variable "private_subnets_cidr" {
  type        = list
  description = "The CIDR block for the private subnet"
}

/*  EC2  */
variable "ec2_ami" {
  description = "The AMI of the EC2 instances"
  default = "ami-05489a3f80e532309"
}

variable "ec2_instance_type" {
  description = "The type of the EC2 instances"
  default = "t2.micro"
}

variable "ec2_user_data_file" {
  description = "The path to the user data file"
  default = "./modules/instances/user-data.sh"
}