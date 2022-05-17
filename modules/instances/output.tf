output "FE_LB_DNS" {
    value = "${aws_lb.albfe.dns_name}"
}

output FE_PUBLIC_IPS {
    value = data.aws_instances.FEInstances.public_ips
}