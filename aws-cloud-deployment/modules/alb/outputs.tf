output "alb_dns_name" {
  description = "DNS-Name des Application Load Balancer"
  value       = aws_lb.main.dns_name
}