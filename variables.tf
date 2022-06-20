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
  type        = list(any)
  description = "The CIDR block for the public subnet"
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "The CIDR block for the private subnet"
}

/*  EC2  */

variable "ec2_instance_type" {
  description = "The type of the EC2 instances"
  default     = "t2.micro"
}

variable "ec2_user_data_file" {
  description = "The path to the user data file"
  default     = "./modules/instances/user-data.sh"
}


variable "fe_asg_desired_capacity" {
  description = "The desired capacity for the frontend autoscaling group"
  type        = number
  default     = 2
}

variable "fe_asg_max_size" {
  description = "The max size of the frontend autoscaling group"
  type        = number
  default     = 3
}

variable "fe_asg_min_size" {
  description = "The min size for the frontend autoscaling group"
  type        = number
  default     = 2
}

variable "be_asg_desired_capacity" {
  description = "The desired capacity for the backend autoscaling group"
  type        = number
  default     = 2
}

variable "be_asg_max_size" {
  description = "The max size of the backend autoscaling group"
  type        = number
  default     = 3
}

variable "be_asg_min_size" {
  description = "The min size for the backend autoscaling group"
  type        = number
  default     = 2
}

variable "do_create_fe_lb" {
  description = "Create or dont create FrontEnd LoadBalancer"
  type = bool
  default = true
}

variable "do_create_be_lb" {
  description = "Create or dont create Backend LoadBalancer"
  type = bool
  default = true
}