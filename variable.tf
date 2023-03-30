
variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t3.large"
}

variable "os_version" {
  type    = string
  default = "ubuntu"
}