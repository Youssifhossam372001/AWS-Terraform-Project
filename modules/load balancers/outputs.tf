output "nlb_dns_name" {
  value = aws_lb.network_lb.dns_name
}

output "alb_dns_name" {
  value = aws_lb.application_lb.dns_name
}
