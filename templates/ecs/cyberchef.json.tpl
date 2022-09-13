[
  {
    "essential": true,
    "name": "cyberchef",
    "memory": ${fargate_memory},
    "cpu": ${fargate_cpu},
    "image": "${app_image}",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/aws/${cloudwatch_group}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "ecs"
      }
    },
    "portMappings": [
      {
        "containerPort": ${container_port},
        "hostPort": ${container_port},
        "protocol": "tcp"
      }
    ]
  }
]
