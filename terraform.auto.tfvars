//AWS 
region      = "eu-west-1"
environment = "app-dev"

/* module networking */
vpc_cidr = "10.0.0.0/20"

/* EC2 */
ec2_instance_type  = "t2.micro"
ec2_user_data_file = "./modules/instances/user-data.sh"

do_create_fe_lb = true
do_create_be_lb = true

do_run_ansible_playbook = true
ansible_command = "ansible-playbook"
ansible_inventory = "ansible/inventory.ini"
ansible_playbook = "ansible/main.yaml"
ansible_tags = ""