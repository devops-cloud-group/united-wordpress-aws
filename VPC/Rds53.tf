resource "aws_route53_record" "db_writer" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "writer"
  type    = "CNAME"
  ttl     = 300
  records = [aws_rds_cluster_instance.writer[0].endpoint]
}



resource "aws_route53_record" "reader" {
  count   = local.readers
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "reader${count.index+1}"
  type    = "CNAME"
  ttl     = 300
  records = [aws_rds_cluster_instance.reader[count.index].endpoint]
}



data "aws_route53_zone" "selected" {
  name = "krotiuk.com."
}

locals {
  readers = length(aws_rds_cluster_instance.reader)
  }
