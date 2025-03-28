variable "vpc_id" {
  description = "ID der VPC"
  type        = string
}

variable "private_subnets" {
  description = "Liste der Private Subnets für EC2"
  type        = list(string)
}

variable "ec2_sg_id" {
  description = "Security Group ID für EC2"
  type        = string
}

variable "ec2_instance_profile" {
  description = "IAM Instance Profile für EC2"
  type        = string
}



variable "ssm_sg_id" {
  description = "Security Group ID für SSM"
  type        = string
}