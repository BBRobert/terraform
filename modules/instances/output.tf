output "FE_LB_DNS" {
    value = "${aws_lb.frontend.dns_name}"
}

output "FE_PUBLIC_IPS" {
    value = data.aws_instances.frontend.public_ips
}