resource "aws_route53_record" "www" {
  zone_id = var.zone.id
  name    = "wordpress.hasanuckun.com"
  type    = "A"

  alias {
    name                   = aws_lb.server.dns_name
    zone_id                = aws_lb.server.zone_id
    evaluate_target_health = true
  }
}


variable "zone_id" {
  default = "Z02872513CHOV2LLJCBMY"
}


output "dns_record_name" {
  value = aws_route53_record.www.name
}
