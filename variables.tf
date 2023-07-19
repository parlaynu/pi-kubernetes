##
## the cluster
##

variable "cluster" {
  type = object({
    virtual_ip = string
    pod_cidr_block = string
  })
  default = {
    virtual_ip = "192.168.99.20/24"
    pod_cidr_block = "10.128.0.0/16"
  }
}


##
## the initial controller
##

variable "controller" {
  type = object({
    name = string
    ip_address = string
    username = string
    ssh_keyfile = string
    priority = number
  })
  default = {
    name = "controller01"
    ip_address = "192.168.99.21"
    username = "ubuntu"
    ssh_keyfile = "~/.ssh/id_rsa"
    priority = 127
  }
}


##
## the secondary controllers - leave empty for non-ha setup
##

variable "secondary" {
  type = map(object({
    ip_address = string
    username = string
    ssh_keyfile = string
    priority = number
    }))
  default = {}
}


##
## the workers
##

variable "workers" {
  type = map(object({
    ip_address = string
    username = string
    ssh_keyfile = string
    }))
  default = {
    worker01 = {
      ip_address = "192.168.99.22"
      username = "ubuntu"
      ssh_keyfile = "~/.ssh/id_rsa"
    },
    worker02 = {
      ip_address = "192.168.99.23"
      username = "ubuntu"
      ssh_keyfile = "~/.ssh/id_rsa"
    }
  }
}

