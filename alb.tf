# Creates the following resources:
# 1. Application Load Balancer
# 2. The Target Group for the ALB
# 3. The listener front-end that faces the internet, with ACM TLS cert

resource "aws_alb" "main" {
  name            = "${local.name_prefix}-alb"
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.alb.id]
}

resource "aws_alb_target_group" "cyberchef" {
  name        = "${local.name_prefix}-tg"
  port        = 80     # This is 80, even though it doesn't match the listener or the container port.
  protocol    = "HTTP" # This is again HTTP and doesn't match the listener.
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    port = var.container_port
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Redirect HTTPS traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = data.aws_acm_certificate.cyberchef_issued.arn
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-2019-08"

  default_action {
    target_group_arn = aws_alb_target_group.cyberchef.arn
    type             = "forward"
  }
}
