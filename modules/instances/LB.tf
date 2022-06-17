resource "aws_lb" "this" {
  name               = "${var.environment}-alb-${var.instance_group}"
  security_groups    = var.security_groups_ids
  subnets            = var.public_subnets_id
  load_balancer_type = "application"

  tags = {
    Name        = "${var.environment}-alb-${var.instance_group}"
    Environment = "${var.environment}"
  }
}


resource "aws_lb_target_group" "this" {
  name     = "${var.environment}-alb-${var.instance_group}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  /* 
    The type of stickiness associated with this target group. 
    If enabled, the load balancer binds a client’s session to a specific instance within the target group . 
*/
  /*
  stickiness {
    type = "lb_cookie"
  }
*/

  tags = {
    Name        = "${var.environment}-alb-${var.instance_group}-tg"
    Environment = "${var.environment}"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.this.arn
    type             = "forward"
  }

  tags = {
    Name        = "${var.environment}-alb-${var.instance_group}-listener-http"
    Environment = "${var.environment}"
  }
}