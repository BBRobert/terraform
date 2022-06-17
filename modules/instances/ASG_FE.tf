resource "aws_autoscaling_group" "frontend" {
  name             = "${var.environment}-asg-frontend"
  desired_capacity = var.fe_asg_desired_capacity
  max_size         = var.fe_asg_max_size
  min_size         = var.fe_asg_min_size

  # link to VPC subnets
  vpc_zone_identifier = var.public_subnets_id

  # link to FE load balancer
  target_group_arns = ["${aws_lb_target_group.frontend.arn}"]

  # EC2 launch template
  launch_template {
    id      = aws_launch_template.ec2.id
    version = aws_launch_template.ec2.latest_version
  }

  tag {
    key                 = "Name"
    value               = "${var.environment}-frontend"
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

# policy for FE auto scaling group
resource "aws_autoscaling_policy" "frontend" {
  name                      = "${aws_autoscaling_group.frontend.name}-target-tracking-policy"
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.frontend.name
  estimated_instance_warmup = 200

  # auto scale based on avg CPU utilization
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = "80"
  }
}

data "aws_instances" "frontend" {
  instance_tags = {
    Name = "${var.environment}-frontend"
  }

  instance_state_names = ["running"]

  depends_on = [aws_autoscaling_group.frontend]
}
