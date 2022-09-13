# Set up CloudWatch groups and streams for ECS Containers
resource "aws_cloudwatch_log_group" "cyberchef_service_log_group" {
  name              = "/aws/${local.name_prefix}"
  retention_in_days = var.log_retention_days
}
