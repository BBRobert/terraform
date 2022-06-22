//AWS 
region      = "eu-west-1"
environment = "app-dev"

/* module networking */
vpc_cidr             = "10.0.0.0/20"

/* EC2 */
ec2_instance_type  = "t2.micro"
ec2_user_data_file = "./modules/instances/user-data.sh"
