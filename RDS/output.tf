output "rds_hostname" {
  description = "RDS Primary instance (writer) hostname"
  value       = aws_rds_cluster.default.endpoint
}

output "rds_reader_endpoint" {
  description = "RDS Primary instance (writer) hostname"
  value       = aws_rds_cluster.default.reader_endpoint
}
output "rds_port" {
  description = "RDS instance port"
  value       = aws_rds_cluster.default.port
}

output "rds_username" {
  description = "RDS instance root username"
  value       = aws_rds_cluster.default.master_username
}


output "all" {
  value = data.terraform_remote_state.backend.outputs.*
}

# output "db_connect_string" {
#   description = "MySQL database connection string"
#   value       = "Server=${aws_rds_cluster.default.endpoint}; Database=AuroraDB; Uid=${var.rds_username}; Pwd=${var.random_password}"
#   sensitive = true
# }