variable "environment" {
  description = "The Deployment environment"
}

variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
  type = string
  default = "10.0.0.0/20"
}

variable "availability_zones" {
  description = "The az that the resources will be launched"
}