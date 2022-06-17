output "LB_DNS" {
  value = aws_lb.this.dns_name
}

output "PUBLIC_IPS" {
  value = data.aws_instances.this.public_ips
}