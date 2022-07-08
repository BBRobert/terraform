variable "subnets_id" {
  type        = list(any)
  description = "The IDs of the subnets"
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

variable "asg_desired_capacity" {
  description = "The desired capacity for the autoscaling group"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "The max size of the autoscaling group"
  type        = number
  default     = 3
}

variable "asg_min_size" {
  description = "The min size of the autoscaling group"
  type        = number
  default     = 2
}

variable "instance_group" {
  description = "The instance group name (backend or frontend)"
  nullable    = false
  type        = string
}

variable "ec2_template" {
  description = "The template of the EC2 instances for the auto scaling group"
  nullable    = false
}

variable "do_create_lb" {
  description = "Create or dont create LB"
  type        = bool
  default     = true
}