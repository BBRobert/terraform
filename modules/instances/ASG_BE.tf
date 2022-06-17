# BE auto scaling group
resource "aws_autoscaling_group" "backend" {
  name             = "${var.environment}-asg-backend"
  desired_capacity = var.be_asg_desired_capacity
  max_size         = var.be_asg_max_size
  min_size         = var.be_asg_min_size

  # link to VPC subnets
  vpc_zone_identifier = var.public_subnets_id

  # EC2 launch template
  launch_template {
    id      = aws_launch_template.ec2.id
    version = aws_launch_template.ec2.latest_version
  }

  tag {
    key                 = "Name"
    value               = "${var.environment}-backend"
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"
    /*
    preferences {
      min_healthy_percentage = 50
    }
    */
    triggers = ["tag"]
  }
}

# policy for BE auto scaling group
resource "aws_autoscaling_policy" "backend" {
  name                      = "${aws_autoscaling_group.backend.name}-target-tracking-policy"
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.backend.name
  estimated_instance_warmup = 200

  # auto scale based on avg CPU utilization
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = "80"
  }
}