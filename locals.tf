
locals {
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  ansible_run = "${var.ansible_command} -i ${var.ansible_inventory} ${var.ansible_playbook}"
}

