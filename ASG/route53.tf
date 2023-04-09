resource "aws_route53_record" "alb" {
  zone_id = "Z0330752YGN7PJ7IYX92"
  name    = "wordpress.litovchenko.net."
  type    = "CNAME"
  ttl     = "300"
  records = [
    aws_lb.server.dns_name
  ]
  lifecycle {
    # To avoid  Route53 error if we start to create new VPC in different region we used lifecycle with condition
    #when we check the region and if it's not a basic "us-west-2" then we will not register new domains and subdomains
    # for the project presentation purposes.
    precondition {
      condition     = var.region == "us-west-2"
      error_message = "We can not use the same domain name in two different region simultaneously"
    }
  }
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
  lifecycle {
    # To avoid  Route53 error if we start to create new VPC in different region we used lifecycle with condition
    #when we check the region and if it's not a basic "us-west-2" then we will not register new domains and subdomains
    # for the project presentation purposes.
    precondition {
      condition     = var.region != "us-west-2"
      error_message = "We can not use the same domain name in two different region simultaneously"
    }
  }
}

variable domain {}

