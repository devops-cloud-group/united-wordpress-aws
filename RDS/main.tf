provider "aws" {
  region = var.region # Region specified in varible.tf file
}

data "terraform_remote_state" "backend" { 
    backend = "s3" 
    config = {
        bucket = "terraform-tfstate-wordpress"
        key    = "env:/${terraform.workspace}/backend/terraform.tfstate"
        region = "us-west-1"
        dynamodb_table = "terraform-prod-lock"
    } 
} 

resource "aws_route53_record" "db_writer" {
  zone_id = data.aws_route53_zone.selected.zone_id
  # name    = "writer.selected"
  name    = "writer.wordpress.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = [aws_rds_cluster_instance.writer[0].endpoint]
}

resource "aws_route53_record" "reader" {
  count   = local.readers
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "reader${count.index+1}.wordpress.${var.domain}"
  # name    = "reader${count.index+1}.selected"
  type    = "CNAME"
  ttl     = 300
  records = [aws_rds_cluster_instance.reader[count.index].endpoint]
}
resource "aws_db_subnet_group" "example" {
  name       = "example-db-subnet-group"
  subnet_ids = [data.terraform_remote_state.backend.outputs.private_subnet_ids[0], data.terraform_remote_state.backend.outputs.private_subnet_ids[1], data.terraform_remote_state.backend.outputs.private_subnet_ids[2]]
}

resource "random_password" "db_master_password" {
  length = 16
  special = true
  override_special = "#!()_"
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.07.2"
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = random_password.db_master_password.result
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot       = true
  vpc_security_group_ids   = [data.terraform_remote_state.backend.outputs.security_group_mysql_id]
  db_subnet_group_name = aws_db_subnet_group.example.name
  
  
  tags = {
    Name = "rds-cluster"
  }
}

resource "aws_rds_cluster_instance" "writer" {
  count                      = 1
  identifier                 = "writer-${count.index}"
  cluster_identifier         = aws_rds_cluster.default.id
  instance_class             = "db.r5.large"
  engine                     = "aurora-mysql"
  publicly_accessible        = false
  tags = {
    Name = "RDS-writer-${count.index}"
  }
}

resource "aws_rds_cluster_instance" "reader" {
  count                      = 3
  identifier                 = "reader-${count.index}"
  cluster_identifier         = aws_rds_cluster.default.id
  instance_class             = "db.r5.large"
  engine                     = "aurora-mysql"
  publicly_accessible        = false
  tags = {
    Name = "RDS-reader-${count.index}"
  }
}
# resource "aws_route53_record" "db_writer" {
#   zone_id = data.aws_route53_zone.selected.zone_id
#   name    = "writer"
#   type    = "CNAME"
#   ttl     = 300
#   records = [aws_rds_cluster_instance.writer[0].endpoint]
# }

# resource "aws_route53_record" "reader" {
#   count   = local.readers
#   zone_id = data.aws_route53_zone.selected.zone_id
#   name    = "reader${count.index+1}"
#   type    = "CNAME"
#   ttl     = 300
#   records = [aws_rds_cluster_instance.reader[count.index].endpoint]
# }