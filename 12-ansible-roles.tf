locals {
  system_role = "system"
  containerd_role = "containerd"
  kubernetes_role = "kubernetes"
  k8s_controller_role = "k8s_controller"
  k8s_secondary_role = "k8s_secondary"
  k8s_controllers_ha_role = "k8s_controllers_ha"
  k8s_worker_role = "k8s_worker"
  k8s_dashboard_role = "k8s_dashboard"
}

resource "template_dir" "system" {
  source_dir      = "templates/ansible-roles/${local.system_role}"
  destination_dir = "local/ansible/roles/${local.system_role}"

  vars = {}
}

resource "template_dir" "containerd" {
  source_dir      = "templates/ansible-roles/${local.containerd_role}"
  destination_dir = "local/ansible/roles/${local.containerd_role}"

  vars = {}
}

resource "template_dir" "kubernetes" {
  source_dir      = "templates/ansible-roles/${local.kubernetes_role}"
  destination_dir = "local/ansible/roles/${local.kubernetes_role}"

  vars = {}
}

resource "random_password" "keepalived" {
  length           = 12
  special          = false
}

resource "template_dir" "k8s_controller" {
  source_dir      = "templates/ansible-roles/${local.k8s_controller_role}"
  destination_dir = "local/ansible/roles/${local.k8s_controller_role}"

  vars = {
    cluster_vip = split("/", var.cluster.virtual_ip)[0]
    cluster_vip_cidr = var.cluster.virtual_ip
    pod_cidr_block = var.cluster.pod_cidr_block
    router_id = 51
    auth_password = random_password.keepalived.result
  }
}

resource "template_dir" "k8s_secondary" {
  source_dir      = "templates/ansible-roles/${local.k8s_secondary_role}"
  destination_dir = "local/ansible/roles/${local.k8s_secondary_role}"

  vars = {}
}

resource "template_dir" "k8s_controllers_ha" {
  source_dir      = "templates/ansible-roles/${local.k8s_controllers_ha_role}"
  destination_dir = "local/ansible/roles/${local.k8s_controllers_ha_role}"

  vars = {
    cluster_vip_cidr = var.cluster.virtual_ip
    router_id = 51
    auth_password = random_password.keepalived.result
  }
}

resource "template_dir" "k8s_worker" {
  source_dir      = "templates/ansible-roles/${local.k8s_worker_role}"
  destination_dir = "local/ansible/roles/${local.k8s_worker_role}"

  vars = {}
}

resource "template_dir" "k8s_dashboard" {
  source_dir      = "templates/ansible-roles/${local.k8s_dashboard_role}"
  destination_dir = "local/ansible/roles/${local.k8s_dashboard_role}"

  vars = {}
}

