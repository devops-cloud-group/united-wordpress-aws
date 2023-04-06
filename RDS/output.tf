output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_rds_cluster.default.endpoint
  sensitive   = true
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_rds_cluster.default.port
  sensitive   = true
}

output "rds_username" {
  description = "RDS instance root username"
  value       = aws_rds_cluster.default.master_username
  sensitive   = true
}