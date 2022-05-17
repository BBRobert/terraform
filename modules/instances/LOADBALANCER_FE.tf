resource "aws_lb" "albfe" {
  name            = "${var.environment}-ALB"
  security_groups = ["${var.security_group_id}"]
  subnets         = "${var.public_subnets_id}"
  load_balancer_type = "application"
}


resource "aws_lb_target_group" "albfetg" {
  name     = "${var.environment}-ALB-FE-TG"
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
}

resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = "${aws_lb.albfe.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.albfetg.arn}"
    type             = "forward"
  }

  depends_on  = [aws_lb.albfe, aws_lb_target_group.albfetg]
}