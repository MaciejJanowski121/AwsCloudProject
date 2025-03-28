# autoscaling.tf
# Auto Scaling Group für EC2
resource "aws_autoscaling_group" "ec2_asg" {
  vpc_zone_identifier = var.private_subnets  # Private Subnet-IDs
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  health_check_type   = "EC2"

  launch_template {
    id      = aws_launch_template.ec2_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "SpringBoot-Backend"
    propagate_at_launch = true
  }
}