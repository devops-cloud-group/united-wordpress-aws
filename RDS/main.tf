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
locals {
  db_instance_count = var.region == "us-west-2" ? 0 : local.readers
}

locals {
  writer_instance_endpoints = [
    for instance in aws_rds_cluster_instance.db_instance :
    instance.writer == true ? instance.endpoint : ""
  ]
}
resource "aws_route53_record" "db_writer" {
  count = local.db_instance_count
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "writer.wordpress.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = [local.writer_instance_endpoints[count.index]]
  # records = [aws_rds_cluster_instance.db_instance[count.index].endpoint]
  
}
locals {
  reader_instance_endpoints = [
    for instance in aws_rds_cluster_instance.db_instance :
    instance.writer ? instance.endpoint : ""
  ]
}
resource "aws_route53_record" "reader" {
  
  count = local.db_instance_count
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "reader${count.index+1}.wordpress.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = [local.reader_instance_endpoints[count.index]]
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
  master_username         = "admin"
  master_password         = random_password.db_master_password.result
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot       = true
  vpc_security_group_ids   = [data.terraform_remote_state.backend.outputs.security_group_mysql_id]
  db_subnet_group_name = aws_db_subnet_group.example.name
  
  
  tags = {
    Name = "Wordpress rds-cluster"
  }
}

resource "aws_rds_cluster_instance" "db_instance" {
  count                      = 4
  identifier                 = "db-instance${count.index+1}"
  cluster_identifier         = aws_rds_cluster.default.id
  instance_class             = "db.t3.small"
  engine                     = "aurora-mysql"
  publicly_accessible        = false
  tags = {
    Name = "RDS-instance-${count.index}"
  }
}
