#------------------------------------------------------------------
# Provision Highly Availabe Web Cluster
# Create:
#    - Security Group for Web Server and ALB
#    - Launch Template with Auto AMI Lookup
#    - Auto Scaling Group using 3 Availability Zones
#    - Application Load Balancer in 3 Availability Zones
#    - Application Load Balancer TargetGroup
#------------------------------------------------------------------
provider "aws" {
  region = var.region # Region specified in varible.tf file
}
  
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]

  }
}



data "terraform_remote_state" "backend" { 
    backend = "s3" 
    config = {
        bucket = "terraform-tfstate-wordpress"
        key    = "env:/${terraform.workspace}/backend/terraform.tfstate"
        region = "us-west-1"
        dynamodb_table = "terraform-prod-lock"
    } 
}

#-------------------------------------------------------------------------------
# resource "aws_security_group" "server" {
#   name   = "Web Security Group"
#   vpc_id = data.terraform_remote_state.backend.outputs.vpc_id 
  
  
#   dynamic "ingress" {
#     for_each = ["80", "443","22"]
#     content {
#       from_port   = ingress.value
#       to_port     = ingress.value
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     Name = "Web Security Group"
#   }
# }

#-------------------------------------------------------------------------------
resource "aws_launch_template" "server" {
  name                   = "WebServer-Highly-Available-LT"
  image_id               = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.terraform_remote_state.backend.outputs.security_group_web_id]
  user_data              = base64encode(file("user_data.sh"))
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "server" {
  name                = "WebServer-Highly-Available-ASG-Ver-${aws_launch_template.server.latest_version}"
  min_size                  = 1
  max_size                  = 99
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  vpc_zone_identifier = [data.terraform_remote_state.backend.outputs.public_subnet_ids[0],data.terraform_remote_state.backend.outputs.public_subnet_ids[1],data.terraform_remote_state.backend.outputs.public_subnet_ids[2]]
  target_group_arns   = [aws_lb_target_group.server.arn]

  launch_template {
    id      = aws_launch_template.server.id
    version = aws_launch_template.server.latest_version
  }
  lifecycle {
    create_before_destroy = true
  }
}

#-------------------------------------------------------------------------------
resource "aws_lb" "server" {
  name               = "WebServer-HighlyAvailable-ALB"
  load_balancer_type = "application"
  #TODO: Check Security Group
  security_groups    = [data.terraform_remote_state.backend.outputs.security_group_web_id]
  subnets            = [data.terraform_remote_state.backend.outputs.public_subnet_ids[0],data.terraform_remote_state.backend.outputs.public_subnet_ids[1],data.terraform_remote_state.backend.outputs.public_subnet_ids[2]]
}

resource "aws_lb_target_group" "server" {
  name                 = "WebServer-HighlyAvailable-TG"
  vpc_id               = data.terraform_remote_state.backend.outputs.vpc_id 
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 10 # seconds
  slow_start           = 0
  health_check {
    matcher             = "200-400"
    timeout             = 5
    unhealthy_threshold = 10
}
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.server.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.server.arn
  }
}

#-------------------------------------------------------------------------------
output "web_loadbalancer_url" {
  value = aws_lb.server.dns_name
}