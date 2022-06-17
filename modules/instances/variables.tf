variable "public_subnets_id" {
  type        = list(any)
  description = "The IDs of the public subnets"
}

variable "environment" {
  description = "The Deployment environment"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "security_groups_ids" {
  description = "The security group IDs"
}

variable "ec2_instance_type" {
  description = "The type of the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "ec2_user_data_file" {
  description = "The path to the user data file"
  type        = string
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