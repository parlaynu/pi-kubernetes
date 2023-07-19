## render the run script

resource "local_file" "run_playbook" {
  content = templatefile("templates/ansible/run-ansible.sh", {
      inventory_file = "inventory.ini"
    })
  filename = "local/ansible/run-ansible.sh"
  file_permission = "0755"
}


## render the inventory file

resource "local_file" "inventory" {
  content = templatefile("templates/ansible/inventory.ini", {
    controller = var.controller,
    secondary = var.secondary,
    workers = var.workers
    })
  filename = "local/ansible/inventory.ini"
  file_permission = "0640"
}

## render the playbook

resource "local_file" "playbook" {
  content = templatefile("templates/ansible/playbook.yml", {
      system_role = local.system_role,
      containerd_role = local.containerd_role,
      kubernetes_role = local.kubernetes_role,
      k8s_controller_role = local.k8s_controller_role,
      k8s_secondary_role = local.k8s_secondary_role,
      k8s_controllers_ha_role = local.k8s_controllers_ha_role,
      k8s_worker_role = local.k8s_worker_role,
      k8s_dashboard_role = local.k8s_dashboard_role,
    })
  filename = "local/ansible/playbook.yml"
}


## render host variables

resource "local_file" "hostvars_controller" {

  content = templatefile("templates/ansible/hostvars_controller.yml", {
    hostname = var.controller.name,
    ip_address = var.controller.ip_address
    priority = var.controller.priority
    primary = var.controller
    secondary = var.secondary
    vrrp_role = "MASTER"
    })

  filename        = "local/ansible/host_vars/${var.controller.name}.yml"
  file_permission = "0640"
}


resource "local_file" "hostvars_secondary" {
  for_each = var.secondary

  content = templatefile("templates/ansible/hostvars_controller.yml", {
    hostname = each.key,
    ip_address = each.value.ip_address
    priority = each.value.priority
    primary = var.controller
    secondary = var.secondary
    vrrp_role = "BACKUP"
    })

  filename        = "local/ansible/host_vars/${each.key}.yml"
  file_permission = "0640"
}


resource "local_file" "hostvars_worker" {
  for_each = var.workers

  content = templatefile("templates/ansible/hostvars_worker.yml", {
    hostname = each.key,
    ip_address = each.value.ip_address
  })

  filename        = "local/ansible/host_vars/${each.key}.yml"
  file_permission = "0640"
}


