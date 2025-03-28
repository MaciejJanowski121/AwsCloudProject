variable "log_group_name" {
  description = "Name der CloudWatch-Loggruppe"
  type        = string
  default     = "/aws/ec2/blog-app"
}

variable "retention_in_days" {
  description = "Anzahl der Tage zur Aufbewahrung von Logs"
  type        = number
  default     = 7
}

variable "alarm_cpu_threshold" {
  description = "CPU-Auslastungsschwelle für EC2-Alarme"
  type        = number
  default     = 80
}

variable "sns_topic_arn" {
  description = "ARN des SNS-Themas für Alarmbenachrichtigungen"
  type        = string
}

variable "vpc_id" {
  description = "VPC-ID für CloudWatch-VPC-Endpunkt"
  type        = string
}

variable "private_subnets" {
  description = "Liste der privaten Subnetze"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID für CloudWatch-VPC-Endpunkt"
  type        = string
}

variable "ec2_instance_id" {
  description = "EC2-Instanz-ID zur Überwachung"
  type        = string
}

variable "rds_instance_id" {
  description = "RDS-Instanz-ID zur Überwachung"
  type        = string
}
