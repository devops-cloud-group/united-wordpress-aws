public_key = "~/.ssh/id_rsa.pub"
region     = "us-west-2"
key_name   = "laptop"                 # change
# zone_id
domain     = "your_domain_name.net"   # change
rds_username = "admin".               # change
rds_password = "***********"          # change 
tags = {
  Name    = "Wordpress-VPC"
  Team    = "AWS"
}
