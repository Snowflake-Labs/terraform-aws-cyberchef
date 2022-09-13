# ALB Security Group: Will only open to VPN Dev.
resource "aws_security_group" "alb" {
  name        = "${local.name_prefix}-alb-sg"
  description = "controls access to the ALB to allow HTTP traffic only from the dev vpn."
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TCP traffic from allowed blocks."
    protocol    = "tcp"
    from_port   = var.host_port
    to_port     = var.host_port
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Traffic to the ECS cluster should only come from the ALB
resource "aws_security_group" "ecs" {
  name        = "${local.name_prefix}-ecs-tasks-sg"
  description = "allow inbound access from the ALB only"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol        = "tcp"
    from_port       = var.container_port
    to_port         = var.container_port
    security_groups = [aws_security_group.alb.id] 
    }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
