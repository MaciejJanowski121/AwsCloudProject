variable "vpc_id" {
  description = "ID der VPC"
  type        = string
}

variable "alb_sg_id" {
  description = "Security Group ID für den Load Balancer"
  type        = string
}

variable "public_subnets" {
  description = "Liste der Subnet-IDs für den öffentlichen Zugriff"
  type        = list(string)
}

variable "ec2_asg_name" {
  description = "Name der Auto Scaling Group mit EC2-Instanzen"
  type        = string
}