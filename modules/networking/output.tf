output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets_id" {
  value = aws_subnet.public_subnet.*.id
}

output "private_subnets_id" {
  value = aws_subnet.private_subnet.*.id
}

output "default_sg_id" {
  value = aws_security_group.default.id
}

output "security_groups_ids" {
  value = {
    "inbound_http" = "${aws_security_group.inbound_http.id}" 
    "inbound_https" = "${aws_security_group.inbound_https.id}" 
    "inbound_ssh" = "${aws_security_group.inbound_ssh.id}" 
    "outbound_all" = "${aws_security_group.outbound_all.id}"
  }
}

output "public_route_table" {
  value = aws_route_table.public.id
}
