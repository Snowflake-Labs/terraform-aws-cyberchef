# Creates the following resources:
# 1. ECS Cluster
# 2. Template file for ECS task definition
# 3. The actual ECS task definition using the template from 2.
# 4. ECS service using the task definition from 3.
resource "aws_ecs_cluster" "main" {
  name = "cyberchef-cluster"
}

# data "template_file" "cyberchef" {
#   template = file("${path.module}/templates/ecs/cyberchef.json.tpl")

#   vars = {
#     app_image        = var.app_image
#     host_port        = var.host_port
#     container_port   = var.container_port
#     fargate_cpu      = var.fargate_cpu
#     fargate_memory   = var.fargate_memory
#     aws_region       = var.aws_region
#     cloudwatch_group = local.name_prefix
#     env              = var.env
#   }
# }


# Cyberchef Service
resource "aws_ecs_task_definition" "cyberchef" {
  family                   = "${local.name_prefix}-task-def"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = templatefile("${path.module}/templates/ecs/cyberchef.json.tpl",
    {
    app_image        = var.app_image
    host_port        = var.host_port
    container_port   = var.container_port
    fargate_cpu      = var.fargate_cpu
    fargate_memory   = var.fargate_memory
    aws_region       = var.aws_region
    cloudwatch_group = local.name_prefix
    env              = var.env
    }
  )
  }

resource "aws_ecs_service" "cyberchef" {
  name                              = "${local.name_prefix}-service"
  cluster                           = aws_ecs_cluster.main.id
  task_definition                   = aws_ecs_task_definition.cyberchef.arn
  desired_count                     = var.app_count
  launch_type                       = "FARGATE"
  health_check_grace_period_seconds = 60

  network_configuration {
    security_groups  = [aws_security_group.ecs.id]
    subnets          = aws_subnet.private.*.id
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.cyberchef.arn
    container_name   = "cyberchef"
    container_port   = var.container_port
  }

  depends_on = [
    aws_alb_listener.front_end,
    aws_iam_role_policy_attachment.attach_task_execution
  ]
}
