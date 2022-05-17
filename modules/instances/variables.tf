variable "public_subnets_id" {
  type        = list
  description = "The IDs of the public subnets"
}

variable "environment" {
  description = "The Deployment environment"
}

variable "vpc_id" {
  description = "The VPC ID"
}

variable "security_groups_ids" {
  description = "The security group IDs"
}

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
