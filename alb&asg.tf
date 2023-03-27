#  Launch configuration
resource "aws_launch_configuration" "lunchconfig" {
  image_id        = data.aws_ami.latest.id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.web.id]
  key_name = var.key_name1

  lifecycle {
    create_before_destroy = true
  }
}

#  ASG
resource "aws_autoscaling_group" "asg" {
  name                 = "example-asg"
  launch_configuration = aws_launch_configuration.lunchconfig.id
  vpc_zone_identifier  = [var.private_subnet_ids]
  min_size             = 1
  max_size             = 99
  desired_capacity     = 1

  lifecycle {
    create_before_destroy = true
  }
}

#  ALB
resource "aws_lb" "alb" {
  name               = "alb-lb"
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [aws_security_group.example_sg.id]

  lifecycle {
    create_before_destroy = true
  }
}

#  ALB Target Group
resource "aws_lb_target_group" "alb-tgroup" {
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}

# Attach Target Group to ASG
resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  alb_target_group_arn   = aws_lb_target_group.alb-tgroup.arn
}

# Create ALB Listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb-tgroup.arn
    type             = "forward"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "example_sg" {
  name_prefix = "example_sg_"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}