module "cyberchef" {
  source = "../"

  aws_region                   = "us-west-2"
  app_name                     = "CyberChef"
  ecs_task_execution_role_name = "CyberChefEcsTaskExecutionRole"
  az_count                     = "3"
  app_image                    = "<your aws account id>.dkr.ecr.us-west-2.amazonaws.com/cyberchef:v9.46.0"

  app_count          = 1
  container_port     = 8080
  log_retention_days = 7
  fargate_cpu        = 2048
  fargate_memory     = 4096

  cyberchef_domain_name = "cyberchef.internal.example.com"
  cyberchef_domain_cert = "*.internal.example.com"
  env                   = "Test"
  hosted_zone           = "internal.example.com"
  hosted_zone_private   = true
}
