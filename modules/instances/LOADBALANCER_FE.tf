resource "aws_lb" "frontend" {
  name            = "${var.environment}-alb-fe"
  security_groups = "${var.security_groups_ids}"
  subnets         = "${var.public_subnets_id}"
  load_balancer_type = "application"

  tags = {
    Name = "${var.environment}-alb-fe"
    Environment = "${var.environment}"
  }
}


resource "aws_lb_target_group" "frontend" {
  name     = "${var.environment}-alb-fe-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
 
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
    Name = "${var.environment}-alb-fe-tg"
    Environment = "${var.environment}"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = "${aws_lb.frontend.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.frontend.arn}"
    type             = "forward"
  }

  tags = {
    Name = "${var.environment}-alb-fe-listener-http"
    Environment = "${var.environment}"
  }

  depends_on  = [aws_lb.frontend, aws_lb_target_group.frontend]
}