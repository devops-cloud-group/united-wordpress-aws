data "aws_route53_zone" "hosted_zone" {
  name = "hasanuckun.com"
}

# terraform aws route 53 record
resource "aws_route53_record" "www" {
  zone_id = "Z02872513CHOV2LLJCBMY"
  name    = "hasanuckun.com"
  type    = "A"

}


#alias {
#  name                   =  #ALB details will be added here 
#  zone_id                =  #ALB zone_id will be added here 
# evaluate_target_health = true 
# }


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