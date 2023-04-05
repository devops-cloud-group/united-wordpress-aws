# resource "aws_route53_record" "db" {
#   zone_id = data.aws_route53_zone.primary.zone_id
#   name    = "wordpress.azimbaev.link"
#   type    = "CNAME"
#   ttl     = "300"

#   records = [
#     "WebServer-HighlyAvailable-ALB2-567939564.us-east-2.elb.amazonaws.com.",
#   ]
# }

# output for domain 
# output "zone_id" {
#   value = aws_route53_record.db.zone_id
# }

# output "name" {
#   value = aws_route53_record.db.name
# }

# output "records" {
#   value = aws_route53_record.db.records
# }