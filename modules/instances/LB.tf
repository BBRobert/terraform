resource "aws_lb" "this" {
  count              = var.do_create_lb ? 1 : 0
  name               = "${var.environment}-alb-${var.instance_group}"
  security_groups    = values(var.security_groups_ids)
  subnets            = var.subnets_id
  load_balancer_type = "application"

  tags = {
    Name        = "${var.environment}-alb-${var.instance_group}"
    Environment = "${var.environment}"
  }
}


resource "aws_lb_target_group" "this" {
  count    = var.do_create_lb ? 1 : 0
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
  count             = var.do_create_lb ? 1 : 0
  load_balancer_arn = aws_lb.this[0].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.this[0].arn
    type             = "forward"
  }

  tags = {
    Name        = "${var.environment}-alb-${var.instance_group}-listener-http"
    Environment = "${var.environment}"
  }
}