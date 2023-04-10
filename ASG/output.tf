# All outputs for RDS team

output "azs" {
  description = "Prints out az names"
  value       = data.aws_availability_zones.available.names
}

output "all" {
  value = data.terraform_remote_state.backend.outputs.*
}

output "web_loadbalancer_url" {
  value = aws_lb.server.dns_name
}