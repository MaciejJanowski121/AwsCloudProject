
# Security Group für den Application Load Balancer (ALB)
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Security Group for ALB"
  vpc_id      = var.vpc_id
  # Erlaubt HTTP-Zugriff von überall (Port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Erlaubt ausgehenden Traffic in alle Richtungen
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB-SG"
  }
}

# Security Group für EC2-Instanzen (Spring Boot App)
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Security Group for EC2"
  vpc_id      = var.vpc_id

  # Erlaubt eingehenden Traffic vom ALB (Port 8080)
  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Erlaubt ausgehenden Traffic in alle Richtungen
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2-SG"
  }
}

# Security Group für SSM VPC Endpoints (für Verwaltung ohne SSH)
resource "aws_security_group" "ssm_sg" {
  name        = "ssm-security-group"
  description = "Security Group for AWS SSM VPC Endpoints"
  vpc_id      = var.vpc_id
  # Erlaubt eingehenden Traffic von EC2 auf Port 443 (HTTPS)
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }
  # Erlaubt ausgehenden HTTPS-Traffic
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SSM-SG"
  }
}

# Security Group für RDS (PostgreSQL-Datenbank)
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Security Group for RDS"
  vpc_id      = var.vpc_id

  tags = {
    Name = "RDS-SG"
  }
}

# Erlaubt EC2 den Zugriff auf die RDS-Instanz (Port 5432)
resource "aws_security_group_rule" "ec2_to_rds" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.ec2_sg.id
}
# Erlaubt RDS ausgehenden Traffic zurück zu EC2
resource "aws_security_group_rule" "rds_to_ec2" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_sg.id
  source_security_group_id = aws_security_group.rds_sg.id
}
# Wird für Interface Endpoints wie Secrets Manager und CloudWatch Logs verwendet
resource "aws_security_group" "vpc_endpoint_sg" {
  name        = "vpc-endpoint-sg"
  description = "Security Group für Interface Endpoints wie Secrets Manager und CloudWatch"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VPC-Endpoint-SG"
  }
}