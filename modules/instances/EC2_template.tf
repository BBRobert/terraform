resource "aws_launch_template" "ec2" {
  name = "${var.environment}-EC2-template"
  image_id      = var.ec2_ami
  instance_type = var.ec2_instance_type
  user_data = filebase64(var.ec2_user_data_file)
  vpc_security_group_ids  = ["${var.security_group_id}"]
}
