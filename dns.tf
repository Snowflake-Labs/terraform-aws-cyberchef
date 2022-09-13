data "aws_route53_zone" "security" {
  name         = var.hosted_zone
  private_zone = var.hosted_zone_private
}

resource "aws_route53_record" "cyberchef_a_record" {
  zone_id = data.aws_route53_zone.security.zone_id
  name    = var.cyberchef_domain_name
  type    = var.hosted_zone_private ? "CNAME" : "A"
  records = var.hosted_zone_private ? [aws_alb.main.dns_name] : null
  ttl     = var.hosted_zone_private ? 300 : null

  dynamic "alias" {
    for_each = var.hosted_zone_private ? [] : [1]
    content {
      name                   = aws_alb.main.dns_name
      zone_id                = aws_alb.main.zone_id
      evaluate_target_health = true
    }
  }
}

data "aws_acm_certificate" "cyberchef_issued" {
  domain   = var.cyberchef_domain_cert
  statuses = ["ISSUED"]
}
