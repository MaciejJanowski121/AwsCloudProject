output "cloudwatch_log_group_name" {
  description = "Name der CloudWatch-Loggruppe"
  value       = aws_cloudwatch_log_group.app_log_group.name
}

output "cloudwatch_cpu_alarm_name" {
  description = "Name des EC2 CPU-Alarms"
  value       = aws_cloudwatch_metric_alarm.cpu_high.alarm_name
}

output "cloudwatch_rds_alarm_name" {
  description = "Name des RDS CPU-Alarms"
  value       = aws_cloudwatch_metric_alarm.rds_cpu_high.alarm_name
}
