#------------------------------------------------------------------
# Provision Highly Availabe Web Cluster
# Create:
#    - Security Group for Web Server and ALB
#    - Launch Template with Auto AMI Lookup
#    - Auto Scaling Group using 3 Availability Zones
#    - Application Load Balancer in 3 Availability Zones
#    - Application Load Balancer TargetGroup
#------------------------------------------------------------------
# data "aws_availability_zones" "available" {
#   state = "available"
# }

# data "aws_ami" "latest_amazon_linux" {
#   owners      = ["137112412989"]
#   most_recent = true
  
#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#   }
# }
#-------------------------------------------------------------------------------
resource "aws_security_group" "server" {
  name   = "Web Security Group"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Web Server Security Group"
  }
}

#-------------------------------------------------------------------------------
resource "aws_launch_template" "server" {
  name                   = "WebServer-Highly-Available-LT"
  image_id               = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.server.id]
  user_data = base64encode(file("user_data.sh"))
  lifecycle {
    create_before_destroy = true
    
  }
}

resource "aws_autoscaling_group" "server" {

  min_size                  = 1
  max_size                  = 99
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  vpc_zone_identifier = [aws_subnet.public_subnet1.id,
  aws_subnet.public_subnet2.id, aws_subnet.public_subnet3.id]
  target_group_arns = [aws_lb_target_group.server.arn]

  launch_template {
    id      = aws_launch_template.server.id
    version = aws_launch_template.server.latest_version
  }

  lifecycle {
    create_before_destroy = true
  }
}



##-------------------------------------------------------------------------------
#resource "aws_lb_target_group_attachment" "asg_attachment" {
 #   target_group_arn = aws_lb_target_group.server.arn
 #   target_id        = aws_autoscaling_group.server.id
  #  port             = 80
  #}

resource "aws_lb" "server" {
  name               = "WebServer-HighlyAvailable-ALB"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.server.id]
  subnets = [aws_subnet.public_subnet2.id,
  aws_subnet.public_subnet1.id, aws_subnet.public_subnet3.id]
}

resource "aws_lb_target_group" "server" {
  name                 = "WebServer-HighlyAvailable-TG"
  vpc_id               = aws_vpc.main.id
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

# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.server.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.server.arn
#   }
# }

#-------------------------------------------------------------------------------
# output "web_loadbalancer_url" {
#   value = aws_lb.server.dns_name
# }
