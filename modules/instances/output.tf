output "LB_DNS" {
  value = var.do_create_lb ? aws_lb.this[0].dns_name : null
}

output "PUBLIC_IPS" {
  value = data.aws_instances.this.public_ips
}

output "PUBLIC_IDS" {
  value = data.aws_instances.this.ids
}

output "PRIVATE_IPS" {
  value = data.aws_instances.this.private_ips
}