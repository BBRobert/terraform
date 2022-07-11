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

resource "time_sleep" "wait_30_secs_for_ansible_playbook" {
  count = var.do_init_ansible_playbook ? 1 : 0

  depends_on = [module.frontend, module.backend]

  create_duration = "30s"
}

resource "null_resource" "run_init_ansible_playbook" {
  count = var.do_init_ansible_playbook ? 1 : 0

  /*
  Tags for ansible playbook:
    init: update all packages; install apache, nano; start apache; create website
    install: install apache, nano
    cleanup: removes apache, nano and website
    update: update all packages
    
    install_apache
    start_apache
    remove_apache
    install_nano
    remove nano
    create_website
    delete_website
  */
  
  provisioner "local-exec" {
    command = "ansible-playbook -i ansible/inventory.ini ansible/main.yaml"
  }

  depends_on = [time_sleep.wait_30_secs_for_ansible_playbook]
}