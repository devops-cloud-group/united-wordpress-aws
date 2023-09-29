provider "aws" {
  region = var.region # Region specified in varible.tf file
}


resource "aws_db_subnet_group" "example" {
  name       = "example-db-subnet-group"
  subnet_ids = [data.terraform_remote_state.network.outputs.private_subnet_ids[0], data.terraform_remote_state.network.outputs.private_subnet_ids[1]]
}

resource "random_password" "db_master_password" {
  length           = 16
  special          = true
  override_special = "#!()_"
}

resource "aws_rds_cluster" "default" {
  cluster_identifier = "aurora-cluster-demo"
  engine             = "aurora-mysql"
  engine_version     = "8.0.mysql_aurora.3.02.2"
  database_name      = "mydb"
  master_username    = var.rds_username
  master_password    = var.rds_password
  # master_password         = random_password.db_master_password.result
  backup_retention_period = 5
  availability_zones      = [data.terraform_remote_state.network.outputs.azs[0], data.terraform_remote_state.network.outputs.azs[1]]
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  vpc_security_group_ids  = [data.terraform_remote_state.network.outputs.security_group_mysql_id]
  db_subnet_group_name    = aws_db_subnet_group.example.name
  tags = {
    Name = "Wordpress rds-cluster"
  }
}

resource "aws_rds_cluster_instance" "db_instance" {
  count               = 2
  identifier          = "db-instance${count.index + 1}"
  cluster_identifier  = aws_rds_cluster.default.id
  instance_class      = "db.t3.medium"
  engine              = "aurora-mysql"
  publicly_accessible = false
  tags = {
    Name = "RDS-instance-${count.index}"
  }
}
#________________________________ROUTE53______________________________________
locals {
  readers = length(aws_rds_cluster_instance.db_instance[*])
}

locals {
  db_instance_count = var.region == "us-west-2" ? local.readers : 0
}

locals {
  writer_instance_endpoints = [
    for instance in aws_rds_cluster_instance.db_instance :
    instance.writer == true ? instance.endpoint : instance.endpoint
  ]
}
resource "aws_route53_record" "db_writer" {
  count   = local.db_instance_count
  zone_id = data.aws_route53_zone.selected.id
  name    = "writer${count.index + 1}.wordpress.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = [local.writer_instance_endpoints[count.index]]
  # records = [aws_rds_cluster_instance.db_instance[count.index].endpoint]

}
locals {
  reader_instance_endpoints = [
    for instance in aws_rds_cluster_instance.db_instance :
    instance.writer ? instance.endpoint : instance.endpoint
  ]
}
resource "aws_route53_record" "reader" {

  count   = local.db_instance_count
  zone_id = data.aws_route53_zone.selected.id
  name    = "reader${count.index + 1}.wordpress.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = [local.reader_instance_endpoints[count.index]]
}
