resource "aws_route53_record" "db" {
  zone_id = "Z075475021FQFGI800HB6"
  name    = "wordpressdb.azimbaev.link"
  type    = "CNAME"
  ttl     = "300"
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