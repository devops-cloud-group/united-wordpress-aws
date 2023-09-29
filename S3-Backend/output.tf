output "terraform_remote_state_s3" {
  description = "terraform_remote_state s3 bucket"
  value       = module.s3_bucket.s3_bucket_id
}
output "terraform_remote_state_s3_region" {
  description = "terraform_remote_state_s3_bucket"
  value       = module.s3_bucket.s3_bucket_region
}

output "terraform_dynamodb" {
  description = "terraform_remote_state_dynamodb"
  value       = aws_dynamodb_table.dynamodb-terraform-state-lock.id
}

