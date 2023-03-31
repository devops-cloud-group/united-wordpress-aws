resource "aws_route53_record" "db" {
  zone_id = "Z02872513CHOV2LLJCBMY"
  name    = "wordpressdb.hasanuckun.com"
  type    = "CNAME"
  ttl     = "300"
  # records = [
  #   rds.name.address
  # ]

}

# output for domain 
output "zone_id" {
  value = aws_route53_record.db.zone_id
}

output "name" {
  value = aws_route53_record.db.name
}

output "records" {
  value = aws_route53_record.db.records
}