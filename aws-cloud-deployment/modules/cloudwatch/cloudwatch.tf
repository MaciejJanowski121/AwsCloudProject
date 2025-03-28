# CloudWatch – Ressourcen zur Überwachung von EC2 und RDS

# Erstellung der Loggruppe für Anwendung
resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
}

# Alarm bei hoher CPU-Auslastung auf EC2
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "High-CPU-Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = var.alarm_cpu_threshold
  alarm_description   = "EC2 CPU > ${var.alarm_cpu_threshold}%"
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    InstanceId = var.ec2_instance_id
  }
}

# Alarm bei hoher CPU-Auslastung auf RDS
resource "aws_cloudwatch_metric_alarm" "rds_cpu_high" {
  alarm_name          = "High-RDS-CPU"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 75
  alarm_description   = "RDS CPU > 75%"
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.rds_instance_id
  }
}
