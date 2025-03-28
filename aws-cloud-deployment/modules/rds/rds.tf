# 📌 PostgreSQL RDS Instanz
resource "aws_db_instance" "rds" {
  identifier              = "my-rds-database"
  engine                  = "postgres"
  engine_version          = "17.2"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  parameter_group_name    = "default.postgres17"
  username                = var.db_username
  password                = var.db_password

  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [var.rds_sg_id]

  publicly_accessible     = false
  multi_az                = false
  skip_final_snapshot     = true

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  tags = {
    Name = "RDS-PostgreSQL"
  }
}

# 📌 Subnet-Gruppe für RDS (für Hochverfügbarkeit in 2 AZs)
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "RDS-Subnet-Group"
  }
}