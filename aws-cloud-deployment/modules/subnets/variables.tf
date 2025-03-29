variable "vpc_id" {
  description = "ID der VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Liste der CIDR-Blöcke für öffentliche Subnetze"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Liste der CIDR-Blöcke für private Subnetze"
  type        = list(string)
}