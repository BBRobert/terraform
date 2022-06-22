resource "aws_autoscaling_group" "this" {
  name             = "${var.environment}-asg-${var.instance_group}"
  desired_capacity = var.asg_desired_capacity
  max_size         = var.asg_max_size
  min_size         = var.asg_min_size

  # link to VPC subnets
  vpc_zone_identifier = var.subnets_id

  # link to FE load balancer
  target_group_arns = ["${aws_lb_target_group.this.arn}"]

  # EC2 launch template
  launch_template {
    id      = var.ec2_template.id
    version = var.ec2_template.latest_version
  }

  tag {
    key                 = "Name"
    value               = "${var.environment}-${var.instance_group}"
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
resource "aws_autoscaling_policy" "this" {
  name                      = "${aws_autoscaling_group.this.name}-target-tracking-policy"
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.this.name
  estimated_instance_warmup = 200

  # auto scale based on avg CPU utilization
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = "80"
  }
}

data "aws_instances" "this" {
  instance_tags = {
    Name = "${var.environment}-${var.instance_group}"
  }

  instance_state_names = ["running"]

  depends_on = [aws_autoscaling_group.this]
}
