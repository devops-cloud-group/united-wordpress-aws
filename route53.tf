resource "aws_route53_record" "alias_route53_record" {
  zone_id = "Z02872513CHOV2LLJCBMY" 
  name    = "wordpress.hasanuckun.com" 
  type    = "A"

  alias {
    name                   = aws_lb.server.dns_name
    zone_id                = aws_lb.server.zone_id
    evaluate_target_health = true
  }
}