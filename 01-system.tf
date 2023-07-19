## ssh setup

resource "local_file" "ssh_config" {
  content = templatefile("templates/ssh.cfg.tpl", {
    controller = var.controller,
    secondary = var.secondary,
    workers = var.workers
    })
    
  filename        = "local/ssh.cfg"
  file_permission = "0640"
}



