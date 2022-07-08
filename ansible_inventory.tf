resource "local_file" "ansible_inventory" {
  content = templatefile("ansible/ansible_inventory.tmpl", {
    fe_public_ips = module.frontend.PUBLIC_IPS,
    fe_public_ids = module.frontend.PUBLIC_IDS,
    be_public_ips = module.backend.PUBLIC_IPS,
    be_public_ids = module.backend.PUBLIC_IDS,
    pk_path       = "keys/${aws_key_pair.this.key_name}.pem",
    ansible_port  = 22,
    ansible_args  = "-o StrictHostKeyChecking=no"
    #ansible_args = ""
  })
  filename = "ansible/inventory.ini"
}

resource "time_sleep" "wait_1_mins_for_ansible_playbook" {
  count = var.do_init_ansible_playbook ? 1 : 0

  depends_on = [module.frontend, module.backend]

  create_duration = "60s"
}

resource "null_resource" "run_init_ansible_playbook" {
  count = var.do_init_ansible_playbook ? 1 : 0
  provisioner "local-exec" {
    command = "ansible-playbook -i ansible/inventory.ini ansible/init.yaml"
  }

  depends_on = [time_sleep.wait_1_mins_for_ansible_playbook]
}