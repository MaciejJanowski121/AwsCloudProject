#Application Load Balancer erstellen
resource "aws_lb" "main" {
  name               = "my-application-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnets

  enable_deletion_protection = false

  tags = {
    Name = "MyALB"
  }
}

# HTTP Listener für Port 80 definieren (weiterleiten an Target Group)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ec2_tg.arn
  }
}

# Zielgruppe für EC2-Instanzen erstellen (Spring Boot läuft auf Port 8080)
resource "aws_lb_target_group" "ec2_tg" {
  name     = "ec2-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

#  Auto Scaling Group mit Target Group verbinden
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = var.ec2_asg_name
  lb_target_group_arn    = aws_lb_target_group.ec2_tg.arn
}