resource "aws_autoscaling_group" "ASGFE" {
  name = "${var.environment}-asg-FE"
  desired_capacity   = 3
  max_size           = 4
  min_size           = 3

    # link to VPC subnets
  vpc_zone_identifier  = "${var.public_subnets_id}"

    # link to FE load balancer
  target_group_arns = ["${aws_lb_target_group.albfetg.arn}"]
  
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

  tag {
    key                 = "Environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

  depends_on  = [aws_launch_template.ec2, aws_lb_target_group.albfetg]
}

# policy for FE auto scaling group
resource "aws_autoscaling_policy" "ASGFE_target_tracking_policy" {
  name = "${aws_autoscaling_group.ASGFE.name}-target-tracking-policy"
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = "${aws_autoscaling_group.ASGFE.name}"
  estimated_instance_warmup = 200

    # auto scale based on avg CPU utilization
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = "80"
  }

  depends_on  = [aws_autoscaling_group.ASGFE]
}

# BE auto scaling group
resource "aws_autoscaling_group" "ASGBE" {
  name = "${var.environment}-asg-BE"
  desired_capacity   = 2
  max_size           = 3
  min_size           = 2

      # link to VPC subnets
  vpc_zone_identifier  = "${var.public_subnets_id}"

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

  tag {
    key                 = "Environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 80
    }
    triggers = ["tag"]
  }

  depends_on  = [aws_launch_template.ec2]
}

# policy for BE auto scaling group
resource "aws_autoscaling_policy" "ASGBE_target_tracking_policy" {
  name = "${aws_autoscaling_group.ASGBE.name}-target-tracking-policy"
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = "${aws_autoscaling_group.ASGBE.name}"
  estimated_instance_warmup = 200

    # auto scale based on avg CPU utilization
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = "80"
  }

  depends_on  = [aws_autoscaling_group.ASGBE]
}