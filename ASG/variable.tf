variable "tags" {
  type    = map(any)
  default = {}
}
variable "domain" {}

variable "region" {}

variable "key_name" {}

variable "public_key" {}

variable "rds_username" {
  description = "Database administrator username"
  type        = string
  sensitive   = true
}
variable "rds_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}



