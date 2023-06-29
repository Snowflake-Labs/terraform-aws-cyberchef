variable "aws_region" {
  description = "The AWS region in which things are created."
  default     = "us-east-2"
}

variable "cidr_block" {
  type        = string
  description = "AWS VPC cidr"
}

variable "env" {
  type        = string
  description = "Environment under which this is being deployed."
  default     = "dev"
}

variable "app_name" {
  description = "Name of the app."
  type        = string
  default     = "cyberchef"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name."
  default     = "cyberchefEcsTaskExecutionRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region."
  default     = "2"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster."
}

variable "host_port" {
  description = "Port exposed by the docker image to redirect traffic to."
  default     = 443
}

variable "protocol" {
  description = "Protocol use for cyberchef URL."
  type        = string
  default     = "HTTPS"
}

variable "log_retention_days" {
  description = "Log retention period in days."
  default     = 0
}

variable "container_port" {
  description = "Port exposed by the cyberchef container."
  default     = 8080
}

variable "app_count" {
  description = "Number of docker containers to run."
  default     = 1
}

variable "health_check_path" {
  description = "ALB Health Check"
  type        = string
  default     = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)."
  default     = 4096
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = 8192
}

variable "cyberchef_domain_name" {
  description = "Domain name used."
}

variable "allowed_cidr_blocks" {
  description = "Allowed list of CIDR Blocks."
  type        = list(string)
  default     = []
}

variable "use_auto_scaling" {
  description = "Set this variable to 'true' to tell autoscaling triggers"
  type        = bool
  default     = false
}

variable "cyberchef_domain_cert" {
  description = "Cert used by CyberChef ALB."
  type        = string
}

variable "hosted_zone" {
  description = "Hosted zone used by the deployment."
  type        = string
}

variable "hosted_zone_private" {
  description = "Hosted zone is a private zone."
  type        = bool
  default     = false
}

