

  resource "aws_db_subnet_group" "example" {
  name        = "my-db-subnet-group"
  description = "Subnet group for my RDS instance"
  subnet_ids  = var.subnet_ids
}
    


resource "random_password" "db_master_password" {
  length = 16
  special = true
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.07.2"
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = "adminkrotiuk"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot       = true
  vpc_security_group_ids   = [var.allow_RDS_sg]
  db_subnet_group_name = aws_db_subnet_group.example.name
   availability_zones = data.aws_availability_zones.available.names
  

  
  tags = {
    Name = "example-rds-cluster"
  }
}

resource "aws_rds_cluster_instance" "writer" {
  count                      = 1
  identifier                 = "example-writer-${count.index}"
  cluster_identifier         = aws_rds_cluster.default.id
  instance_class             = "db.r5.large"
  engine                     = "aurora-mysql"
  publicly_accessible        = false
  tags = {
    Name = "example-writer-${count.index}"
  }
}

resource "aws_rds_cluster_instance" "reader" {
  count                      = 3
  identifier                 = "example-reader-${count.index+1}"
  cluster_identifier         = aws_rds_cluster.default.id
  instance_class             = "db.r5.large"
  engine                     = "aurora-mysql"
  publicly_accessible        = false
  tags = {
    Name = "example-reader-${count.index}"
  }
}









