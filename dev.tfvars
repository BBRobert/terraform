//AWS 
region      = "eu-west-1"
environment = "app-dev"

/* module networking */
vpc_cidr             = "10.0.0.0/20"
public_subnets_cidr  = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"] //List of Public subnet cidr range
private_subnets_cidr = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"] //List of private subnet cidr range

/* EC2 */
ec2_instance_type  = "t2.micro"
ec2_user_data_file = "./modules/instances/user-data.sh"

do_create_fe_lb = true
do_create_be_lb = false