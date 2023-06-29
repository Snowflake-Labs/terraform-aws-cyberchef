# terraform-aws-cyberchef
Terraform module to setup AWS infrastracture to host CyberChef application.  The module will create iam, alb, dns, ecs and various network resources, to hos the appliction running in a Docker container on the AWS ECS service.

## Required parameters
| Parameter| Description  |
| --- | --- |
|cidr_block|VPC CIDR block to create.  Example: `172.80.0.0/20`|
| cyberchef_domain_name |The FQDN host name of the cyberchef to create. Example: `cyberchef.internal.example.com`|
|hosted_zone|Existing Route53 hosted zone to use. Example: `internal.example.com`|
| cyberchef_domain_cert|Existing ACM cert to use. Example: `*.internal.example.com`|
|app_image|Existing ECR container image name to use. Default: `<aws account number>.dkr.ecr.us-west-2.amazonaws.com/cyberchef:v9.46.0`|

## Optional parameters
| Parameter| Description  |
| --- | --- |
| aws_region |AWS region. Default: `aws_region`|
|env|Environment. Default: `dev`|
| app_name|Application name. Default: `cyberchef`|
|ecs_task_execution_role_name|IAM role to create for the ECS task execution. Default: `cyberchefEcsTaskExecutionRole`|
|az_count|Number of availability zones to use. Default: `2`|
|host_port|Inbound traffic port. Default: `443`|
|container_port|Listening port on the container. Default: `8080`|
|protocol|Inbound traffic protocol. Default `HTTPS`|
|log_retention_days|Number of days to retain log from ECS. Default: `0`|
|app_count|Number of container count.  Default: `1`|
|health_check_path|ALB health check URI. Default: `/`|
|fargate_cpu|Fargate instance CPU units to provision. Default: `4096` |
|fargate_memory|Fargate instance memory, in MiB, to provision. Default: `8192`|
|allowed_cidr_blocks|List of CIDR to whitelist. Default: `[]`|
|use_auto_scaling|Use autoscaling. Default: `false`|
|hosted_zone_private|The Route53 hosted zone, `hosted_zone`, is private. Default: `false`|
