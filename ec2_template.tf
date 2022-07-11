data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_template" "ec2" {
  name          = "${var.environment}-ec2-template"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.ec2_instance_type
  #user_data              = filebase64(var.ec2_user_data_file)
  vpc_security_group_ids = values(module.networking.security_groups_ids)
  key_name               = aws_key_pair.this.key_name
  tag_specifications {
    resource_type = "instance"

    tags = {
      Environment = "${var.environment}"
      Name        = "${var.environment}-ec2-instance"
    }
  }
}