resource "aws_route53_record" "www" {
  zone_id = "Z02872513CHOV2LLJCBMY"
  name    = "blog.hasanuckun.com"
  type    = "A"
  ttl     = 300
  records = ["127.0.0.1"]
  #records = [aws_lb.MYALB.dns_name] 

}

# output for domain 
output "zone_id" {
  value = aws_route53_record.www.zone_id
}

output "name" {
  value = aws_route53_record.www.name
}

output "records" {
  value = aws_route53_record.www.records
}