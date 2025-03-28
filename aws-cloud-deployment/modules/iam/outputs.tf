output "ec2_iam_role" {
  description = "IAM-Rolle für EC2"
  value       = aws_iam_role.ec2_role.name
}

output "ec2_instance_profile" {
  description = "IAM Instance Profile für EC2"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "ec2_instance_profile_id" {
  description = "ID des Instance Profiles"
  value       = aws_iam_instance_profile.ec2_profile.id
}