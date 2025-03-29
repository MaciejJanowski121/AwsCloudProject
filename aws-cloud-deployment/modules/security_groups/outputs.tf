output "alb_sg_id" {
  description = "ID der Security Group für den Application Load Balancer"
  value       = aws_security_group.alb_sg.id
}

output "ec2_sg_id" {
  description = "ID der Security Group für EC2-Instanzen"
  value       = aws_security_group.ec2_sg.id
}

output "rds_sg_id" {
  description = "ID der Security Group für RDS"
  value       = aws_security_group.rds_sg.id
}

output "ssm_sg_id" {
  description = "ID der Security Group für AWS SSM Endpoints"
  value       = aws_security_group.ssm_sg.id
}

output "vpc_endpoint_sg_id" {
  description = "ID der Security Group für Secrets Manager / andere VPC Endpoints"
  value       = aws_security_group.vpc_endpoint_sg.id
}