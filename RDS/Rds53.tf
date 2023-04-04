

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






locals {
  readers = length(aws_rds_cluster_instance.reader)
  }



# resource "aws_route53_record" "db_writer" {
#   zone_id = data.aws_route53_zone.selected.zone_id
#   name    = "writer"
#   type    = "CNAME"
#   ttl     = 300
#   records = [aws_rds_cluster_instance.writer.endpoint]
# }



# resource "aws_route53_record" "reader1" {
#   //count   = local.readers
#   zone_id = data.aws_route53_zone.selected.zone_id
#   name    = "reader-1"
#   type    = "CNAME"
#   ttl     = 300
#   records = [aws_rds_cluster_instance.reader1.endpoint]
# }


# resource "aws_route53_record" "reader2" {
#   //count   = local.readers
#   zone_id = data.aws_route53_zone.selected.zone_id
#   name    = "reader-2"
#   type    = "CNAME"
#   ttl     = 300
#   records = [aws_rds_cluster_instance.reader2.endpoint]
# }

# resource "aws_route53_record" "reader3" {
#   //count   = local.readers
#   zone_id = data.aws_route53_zone.selected.zone_id
#   name    = "reader-3"
#   type    = "CNAME"
#   ttl     = 300
#   records = [aws_rds_cluster_instance.reader3.endpoint]
# }


data "aws_route53_zone" "selected" {
  name = "azimbaev.link"
}

# locals {
#   readers = length(aws_rds_cluster_instance.reader)
#   }


