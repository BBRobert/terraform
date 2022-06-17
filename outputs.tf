output "FE_LB_DNS" {
  value = module.frontend.LB_DNS
}

output "FE_INSTANCES_PUBLIC_IPs" {
  value = module.frontend.PUBLIC_IPS
}

output "FE_INSTANCES_PRIVATE_IPs" {
  value = module.frontend.PRIVATE_IPS
}