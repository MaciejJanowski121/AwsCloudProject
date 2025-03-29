variable "iam_role_name" {
  description = "Name der IAM-Rolle für EC2"
  default     = "EC2Role"
}

variable "secret_arn" {
  description = "ARN des Secrets im Secrets Manager"
  type        = string
}