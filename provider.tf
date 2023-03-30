provider "aws" {
  region = var.region # Region specified in varible.tf file

  default_tags {
    tags = {
      CreatedBy = "Terraform"
    }
  }
}
