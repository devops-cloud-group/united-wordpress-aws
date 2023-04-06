resource "aws_route53_record" "alb" {
  zone_id = "Z0330752YGN7PJ7IYX92"
  name    = "wordpress.litovchenko.net."
  type    = "CNAME"
  ttl     = "300"
  records = [
    aws_lb.server.dns_name
  ]
}

# # output for domain 
# output "zone_id" {
#   value = aws_route53_record.db.zone_id
# }

# output "name" {
#   value = aws_route53_record.db.name
# }

# output "records" {
#   value = aws_route53_record.db.records
# }

output "wordpress_records" {
  value = aws_route53_record.alb.records
}

data "aws_route53_zone" "selected" {
  name         = var.domain
  private_zone = false
}

variable domain {}

