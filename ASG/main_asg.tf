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
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


#-------------------------------------------------------------------------------
resource "aws_security_group" "web" {
  name   = "Web Security Group"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id 
  
  
  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Web Security Group"
  }
}

#-------------------------------------------------------------------------------
# resource "aws_launch_template" "web" {
#   name                   = "WebServer-Highly-Available-LT"
#   image_id               = data.aws_ami.latest_amazon_linux.id
#   instance_type          = "t3.micro"
#   vpc_security_group_ids = [aws_security_group.web.id]
#   user_data              = filebase64("${path.module}/user_data.sh")
# }

resource "aws_autoscaling_group" "web" {
  name                = "WebServer-Highly-Available-ASG-Ver-${aws_launch_template.web.latest_version}"
  min_size            = 2
  max_size            = 2
  min_elb_capacity    = 2
  health_check_type   = "ELB"
  vpc_zone_identifier = [aws_subnet.public_subnet1.id,
  aws_subnet.public_subnet2.id, aws_subnet.public_subnet3.id]
  target_group_arns   = [aws_lb_target_group.web.arn]

  launch_template {
    id      = aws_launch_template.web.id
    version = aws_launch_template.web.latest_version
  }

  dynamic "tag" {
    for_each = {
      Name   = "WebServer in ASG-v${aws_launch_template.web.latest_version}"
      TAGKEY = "TAGVALUE"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

#-------------------------------------------------------------------------------
resource "aws_lb" "web" {
  name               = "WebServer-HighlyAvailable-ALB"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web.id]
  subnets            = [aws_subnet.public_subnet2.id,
  aws_subnet.public_subnet1.id, aws_subnet.public_subnet3.id]
}

resource "aws_lb_target_group" "web" {
  name                 = "WebServer-HighlyAvailable-TG"
  vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id 
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 10 # seconds
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

#-------------------------------------------------------------------------------
output "web_loadbalancer_url" {
  value = aws_lb.web.dns_name
}