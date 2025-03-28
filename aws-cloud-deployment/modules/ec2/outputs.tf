output "ec2_asg_name" {
  description = "Name der Auto Scaling Group"
  value       = aws_autoscaling_group.ec2_asg.name
}

output "ec2_template_id" {
  description = "ID des EC2 Launch Templates"
  value       = aws_launch_template.ec2_template.id
}