variable "vpc_id" {
  description = "Die ID der VPC"
  type        = string
}

variable "igw_id" {
  description = "Die ID des Internet-Gateways"
  type        = string
}

variable "public_subnets" {
  description = "Liste der Public Subnet-IDs"
  type        = list(string)
}

variable "private_subnets" {
  description = "Liste der Private Subnet-IDs (CIDR)"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Liste der Private Subnet-IDs"
  type        = list(string)
}

variable "aws_region" {
  description = "AWS-Region"
  type        = string
}

variable "ec2_sg_id" {
  description = "Security Group ID für EC2-Instanzen (optional)"
  type        = string
}

variable "ssm_sg_id" {
  description = "Security Group für SSM Endpoints"
  type        = string
}

variable "private_route_table_ids" {
  description = "IDs der privaten Route Tables (für Gateway Endpoint z.B. S3)"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID für CloudWatch Endpoint"
  type        = string
}

variable "vpc_endpoint_sg_id" {
  description = "Security Group ID für Secrets Manager Endpoint"
  type        = string
}